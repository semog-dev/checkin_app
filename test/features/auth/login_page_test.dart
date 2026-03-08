import 'package:checkin_app/features/auth/presentation/pages/login_page.dart';
import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:domain/src/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthRepository implements AuthRepository {
  Exception? errorToThrow;
  bool signInCalled = false;

  @override
  Stream<String?> watchAuthStateChanges() => const Stream.empty();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    signInCalled = true;
  }

  @override
  Future<void> signOut() async {}
}

Widget _buildPage({AuthRepository? repo}) {
  return ProviderScope(
    overrides: [
      if (repo != null) authRepositoryProvider.overrideWithValue(repo),
    ],
    child: const MaterialApp(home: LoginPage()),
  );
}

void main() {
  group('LoginPage', () {
    group('estrutura visual', () {
      testWidgets('exibe campo de email', (tester) async {
        await tester.pumpWidget(_buildPage());

        expect(find.byKey(const Key('email_field')), findsOneWidget);
      });

      testWidgets('exibe campo de senha', (tester) async {
        await tester.pumpWidget(_buildPage());

        expect(find.byKey(const Key('password_field')), findsOneWidget);
      });

      testWidgets('campo de senha está obscurecido', (tester) async {
        await tester.pumpWidget(_buildPage());

        final passwordField = tester.widget<TextField>(
          find.byKey(const Key('password_field')),
        );
        expect(passwordField.obscureText, isTrue);
      });

      testWidgets('exibe botão de entrar', (tester) async {
        await tester.pumpWidget(_buildPage());

        expect(find.byKey(const Key('login_button')), findsOneWidget);
      });
    });

    group('comportamento', () {
      testWidgets('botão entrar chama signIn com email e senha preenchidos', (
        tester,
      ) async {
        final repo = _FakeAuthRepository();
        await tester.pumpWidget(_buildPage(repo: repo));

        await tester.enterText(
          find.byKey(const Key('email_field')),
          'alice@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'senha123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(repo.signInCalled, isTrue);
      });

      testWidgets('exibe CircularProgressIndicator durante login', (
        tester,
      ) async {
        // Usa um repositório que demora para responder
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWithValue(
                _SlowAuthRepository(),
              ),
            ],
            child: const MaterialApp(home: LoginPage()),
          ),
        );

        await tester.enterText(
          find.byKey(const Key('email_field')),
          'alice@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'senha123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump(); // um frame após o tap

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Drena o timer pendente para evitar assertion error no teardown
        await tester.pump(const Duration(seconds: 10));
      });

      testWidgets('exibe mensagem de erro quando login falha', (tester) async {
        final repo = _FakeAuthRepository()
          ..errorToThrow = Exception('credenciais inválidas');
        await tester.pumpWidget(_buildPage(repo: repo));

        await tester.enterText(
          find.byKey(const Key('email_field')),
          'wrong@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'errada',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pumpAndSettle();

        expect(find.textContaining('credenciais inválidas'), findsOneWidget);
      });

      testWidgets('não chama signIn quando email está vazio', (tester) async {
        final repo = _FakeAuthRepository();
        await tester.pumpWidget(_buildPage(repo: repo));

        await tester.enterText(
          find.byKey(const Key('password_field')),
          'senha123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(repo.signInCalled, isFalse);
      });

      testWidgets('não chama signIn quando senha está vazia', (tester) async {
        final repo = _FakeAuthRepository();
        await tester.pumpWidget(_buildPage(repo: repo));

        await tester.enterText(
          find.byKey(const Key('email_field')),
          'alice@example.com',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(repo.signInCalled, isFalse);
      });
    });
  });
}

class _SlowAuthRepository implements AuthRepository {
  @override
  Stream<String?> watchAuthStateChanges() => const Stream.empty();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      Future.delayed(const Duration(seconds: 10));

  @override
  Future<void> signOut() async {}
}
