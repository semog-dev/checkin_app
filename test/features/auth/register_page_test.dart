import 'package:checkin_app/features/auth/presentation/pages/register_page.dart';
import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:domain/src/repositories/auth_repository.dart';
import 'package:domain/src/repositories/user_repository.dart';
import 'package:domain/src/entities/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthRepository implements AuthRepository {
  bool signUpCalled = false;
  String? lastDisplayName;
  Exception? errorToThrow;

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
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    signUpCalled = true;
    lastDisplayName = displayName;
    return 'new-uid';
  }

  @override
  Future<void> signOut() async {}
}

class _FakeUserRepository implements UserRepository {
  @override
  Stream<UserProfile?> watchCurrentUser() => const Stream.empty();

  @override
  Stream<UserProfile?> watchUserById(String uid) => const Stream.empty();

  @override
  Future<UserProfile?> getUserById(String uid) async => null;

  @override
  Future<void> updateProfile(UserProfile profile) async {}

  @override
  Future<void> updateStatus(String uid, UserStatus status) async {}
}

Widget _buildPage({_FakeAuthRepository? authRepo}) {
  return ProviderScope(
    overrides: [
      authRepositoryProvider
          .overrideWithValue(authRepo ?? _FakeAuthRepository()),
      userRepositoryProvider.overrideWithValue(_FakeUserRepository()),
    ],
    child: const MaterialApp(home: RegisterPage()),
  );
}

void main() {
  group('RegisterPage', () {
    group('estrutura visual', () {
      testWidgets('exibe campo de nome', (tester) async {
        await tester.pumpWidget(_buildPage());
        expect(find.byKey(const Key('name_field')), findsOneWidget);
      });

      testWidgets('exibe campo de email', (tester) async {
        await tester.pumpWidget(_buildPage());
        expect(find.byKey(const Key('email_field')), findsOneWidget);
      });

      testWidgets('exibe campo de senha', (tester) async {
        await tester.pumpWidget(_buildPage());
        expect(find.byKey(const Key('password_field')), findsOneWidget);
      });

      testWidgets('exibe botão de cadastrar', (tester) async {
        await tester.pumpWidget(_buildPage());
        expect(find.byKey(const Key('register_button')), findsOneWidget);
      });

      testWidgets('campo de senha está obscurecido', (tester) async {
        await tester.pumpWidget(_buildPage());
        final editableText = tester.widget<EditableText>(
          find
              .descendant(
                of: find.byKey(const Key('password_field')),
                matching: find.byType(EditableText),
              )
              .first,
        );
        expect(editableText.obscureText, isTrue);
      });
    });

    group('comportamento', () {
      testWidgets('não chama signUp quando nome está vazio', (tester) async {
        final repo = _FakeAuthRepository();
        await tester.pumpWidget(_buildPage(authRepo: repo));

        await tester.enterText(
          find.byKey(const Key('email_field')),
          'alice@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'senha123',
        );
        await tester.tap(find.byKey(const Key('register_button')));
        await tester.pump();

        expect(repo.signUpCalled, isFalse);
      });

      testWidgets('não chama signUp quando email está vazio', (tester) async {
        final repo = _FakeAuthRepository();
        await tester.pumpWidget(_buildPage(authRepo: repo));

        await tester.enterText(
          find.byKey(const Key('name_field')),
          'Alice',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'senha123',
        );
        await tester.tap(find.byKey(const Key('register_button')));
        await tester.pump();

        expect(repo.signUpCalled, isFalse);
      });

      testWidgets('não chama signUp quando senha está vazia', (tester) async {
        final repo = _FakeAuthRepository();
        await tester.pumpWidget(_buildPage(authRepo: repo));

        await tester.enterText(find.byKey(const Key('name_field')), 'Alice');
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'alice@example.com',
        );
        await tester.tap(find.byKey(const Key('register_button')));
        await tester.pump();

        expect(repo.signUpCalled, isFalse);
      });

      testWidgets('chama signUp com campos preenchidos', (tester) async {
        final repo = _FakeAuthRepository();
        await tester.pumpWidget(_buildPage(authRepo: repo));

        await tester.enterText(find.byKey(const Key('name_field')), 'Alice');
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'alice@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'senha123',
        );
        await tester.tap(find.byKey(const Key('register_button')));
        await tester.pump();

        expect(repo.signUpCalled, isTrue);
        expect(repo.lastDisplayName, 'Alice');
      });

      testWidgets('exibe mensagem de erro quando cadastro falha',
          (tester) async {
        final repo = _FakeAuthRepository()
          ..errorToThrow = Exception('email-already-in-use');
        await tester.pumpWidget(_buildPage(authRepo: repo));

        await tester.enterText(find.byKey(const Key('name_field')), 'Alice');
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'alice@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'senha123',
        );
        await tester.tap(find.byKey(const Key('register_button')));
        await tester.pump(); // inicia signUp
        await tester.pump(const Duration(milliseconds: 100)); // processa async
        await tester.pump(const Duration(milliseconds: 500)); // exibe snackbar

        expect(find.text('E-mail já cadastrado.'), findsOneWidget);
      });
    });
  });
}
