import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthState', () {
    group('factory constructors', () {
      test('initial() cria estado inicial', () {
        const state = AuthState.initial();
        expect(state, isA<AuthInitial>());
      });

      test('authenticated() carrega uid', () {
        const state = AuthState.authenticated(uid: 'user-123');
        expect(state, isA<AuthAuthenticated>());
        expect((state as AuthAuthenticated).uid, 'user-123');
      });

      test('unauthenticated() cria estado deslogado', () {
        const state = AuthState.unauthenticated();
        expect(state, isA<AuthUnauthenticated>());
      });

      test('error() carrega mensagem', () {
        const state = AuthState.error(message: 'credenciais inválidas');
        expect(state, isA<AuthError>());
        expect((state as AuthError).message, 'credenciais inválidas');
      });
    });

    group('igualdade', () {
      test('initial() == initial()', () {
        expect(const AuthState.initial(), equals(const AuthState.initial()));
      });

      test('authenticated com mesmo uid são iguais', () {
        expect(
          const AuthState.authenticated(uid: 'u1'),
          equals(const AuthState.authenticated(uid: 'u1')),
        );
      });

      test('authenticated com uids diferentes não são iguais', () {
        expect(
          const AuthState.authenticated(uid: 'u1'),
          isNot(equals(const AuthState.authenticated(uid: 'u2'))),
        );
      });

      test('unauthenticated() == unauthenticated()', () {
        expect(
          const AuthState.unauthenticated(),
          equals(const AuthState.unauthenticated()),
        );
      });

      test('error com mesma mensagem são iguais', () {
        expect(
          const AuthState.error(message: 'erro'),
          equals(const AuthState.error(message: 'erro')),
        );
      });
    });

    group('pattern matching — when()', () {
      test('initial redireciona para initial branch', () {
        const state = AuthState.initial();
        final result = state.when(
          initial: () => 'initial',
          authenticated: (_) => 'authenticated',
          unauthenticated: () => 'unauthenticated',
          error: (_) => 'error',
        );
        expect(result, 'initial');
      });

      test('authenticated redireciona para authenticated branch com uid', () {
        const state = AuthState.authenticated(uid: 'u42');
        final result = state.when(
          initial: () => '',
          authenticated: (uid) => uid,
          unauthenticated: () => '',
          error: (_) => '',
        );
        expect(result, 'u42');
      });

      test('unauthenticated redireciona para unauthenticated branch', () {
        const state = AuthState.unauthenticated();
        final result = state.when(
          initial: () => false,
          authenticated: (_) => false,
          unauthenticated: () => true,
          error: (_) => false,
        );
        expect(result, isTrue);
      });

      test('error redireciona para error branch com mensagem', () {
        const state = AuthState.error(message: 'falhou');
        final result = state.when(
          initial: () => '',
          authenticated: (_) => '',
          unauthenticated: () => '',
          error: (msg) => msg,
        );
        expect(result, 'falhou');
      });
    });
  });
}
