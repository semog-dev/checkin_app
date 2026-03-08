import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:domain/src/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock local para isolar o notifier
class _FakeAuthRepository implements AuthRepository {
  String? uidToEmit;
  Exception? errorToThrow;
  String? lastSignInEmail;
  String? lastSignInPassword;
  bool signOutCalled = false;

  @override
  Stream<String?> watchAuthStateChanges() {
    if (errorToThrow != null) return Stream.error(errorToThrow!);
    return Stream.value(uidToEmit);
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastSignInEmail = email;
    lastSignInPassword = password;
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return 'mock-uid';
  }

  @override
  Future<void> signOut() async {
    if (errorToThrow != null) throw errorToThrow!;
    signOutCalled = true;
  }
}

ProviderContainer _makeContainer(_FakeAuthRepository repo) {
  final container = ProviderContainer(
    overrides: [authRepositoryProvider.overrideWithValue(repo)],
  );
  // Eager init: aciona o build() para que a stream já esteja subscrita
  // antes de qualquer await no teste.
  container.read(authNotifierProvider);
  return container;
}

void main() {
  group('AuthNotifier', () {
    test('estado inicial é AuthState.initial()', () {
      final container = _makeContainer(_FakeAuthRepository());
      addTearDown(container.dispose);

      expect(container.read(authNotifierProvider), const AuthState.initial());
    });

    test('torna-se authenticated quando repositório emite uid', () async {
      final repo = _FakeAuthRepository()..uidToEmit = 'user-99';
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      // Aguarda a stream processar
      await Future.microtask(() {});

      expect(
        container.read(authNotifierProvider),
        const AuthState.authenticated(uid: 'user-99'),
      );
    });

    test('torna-se unauthenticated quando repositório emite null', () async {
      final repo = _FakeAuthRepository()..uidToEmit = null;
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await Future.microtask(() {});

      expect(
        container.read(authNotifierProvider),
        const AuthState.unauthenticated(),
      );
    });

    test('torna-se error quando repositório emite erro no stream', () async {
      final repo = _FakeAuthRepository()
        ..errorToThrow = Exception('erro de auth');
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await Future.microtask(() {});

      expect(container.read(authNotifierProvider), isA<AuthError>());
    });

    test('signIn chama repositório com email e senha corretos', () async {
      final repo = _FakeAuthRepository();
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await container
          .read(authNotifierProvider.notifier)
          .signIn(email: 'alice@example.com', password: 'senha123');

      expect(repo.lastSignInEmail, 'alice@example.com');
      expect(repo.lastSignInPassword, 'senha123');
    });

    test('signIn com credenciais inválidas resulta em AuthError', () async {
      final repo = _FakeAuthRepository()
        ..errorToThrow = Exception('credenciais inválidas');
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await container
          .read(authNotifierProvider.notifier)
          .signIn(email: 'wrong@example.com', password: 'errada');

      final state = container.read(authNotifierProvider);
      expect(state, isA<AuthError>());
      expect((state as AuthError).message, contains('credenciais inválidas'));
    });

    test('signOut chama repositório', () async {
      final repo = _FakeAuthRepository();
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await container.read(authNotifierProvider.notifier).signOut();

      expect(repo.signOutCalled, isTrue);
    });
  });
}
