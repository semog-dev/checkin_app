import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── State ────────────────────────────────────────────────────────────────────

sealed class AuthState {
  const AuthState();

  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.authenticated({required String uid}) =
      AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.error({required String message}) = AuthError;

  T when<T>({
    required T Function() initial,
    required T Function(String uid) authenticated,
    required T Function() unauthenticated,
    required T Function(String message) error,
  }) =>
      switch (this) {
        AuthInitial() => initial(),
        AuthAuthenticated(:final uid) => authenticated(uid),
        AuthUnauthenticated() => unauthenticated(),
        AuthError(:final message) => error(message),
      };
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  bool operator ==(Object other) => other is AuthInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required this.uid});
  final String uid;

  @override
  bool operator ==(Object other) =>
      other is AuthAuthenticated && other.uid == uid;

  @override
  int get hashCode => uid.hashCode;
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();

  @override
  bool operator ==(Object other) => other is AuthUnauthenticated;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class AuthError extends AuthState {
  const AuthError({required this.message});
  final String message;

  @override
  bool operator ==(Object other) =>
      other is AuthError && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

// ── Providers ────────────────────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => const _NoopAuthRepository(),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => throw UnimplementedError('userRepositoryProvider not overridden'),
);

final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

final currentUserProfileProvider = StreamProvider<UserProfile?>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.watchCurrentUser();
});

// ── Noop default (usado em testes sem override) ───────────────────────────────

class _NoopAuthRepository implements AuthRepository {
  const _NoopAuthRepository();

  @override
  Stream<String?> watchAuthStateChanges() => const Stream.empty();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async =>
      '';

  @override
  Future<void> signOut() async {}
}

// ── Notifier ─────────────────────────────────────────────────────────────────

class AuthNotifier extends Notifier<AuthState> {
  StreamSubscription<String?>? _sub;

  @override
  AuthState build() {
    final repository = ref.watch(authRepositoryProvider);

    _sub?.cancel();
    _sub = repository.watchAuthStateChanges().listen(
      (uid) {
        state = uid != null
            ? AuthState.authenticated(uid: uid)
            : const AuthState.unauthenticated();
      },
      onError: (Object e) {
        state = AuthState.error(message: e.toString());
      },
    );

    ref.onDispose(() => _sub?.cancel());

    return const AuthState.initial();
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
            email: email,
            password: password,
          );
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final uid = await ref
          .read(authRepositoryProvider)
          .signUpWithEmailAndPassword(
            email: email,
            password: password,
            displayName: displayName,
          );
      // Cria o UserProfile no Firestore logo após o cadastro
      await ref.read(userRepositoryProvider).updateProfile(
            UserProfile(
              uid: uid,
              displayName: displayName,
              email: email,
              status: UserStatus.offline,
            ),
          );
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}
