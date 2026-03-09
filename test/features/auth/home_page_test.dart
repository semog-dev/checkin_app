import 'package:checkin_app/features/auth/presentation/pages/home_page.dart';
import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:domain/src/entities/user_profile.dart';
import 'package:domain/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeUserRepository implements UserRepository {
  final UserProfile? profile;

  _FakeUserRepository({this.profile});

  @override
  Stream<UserProfile?> watchCurrentUser() => Stream.value(profile);

  @override
  Stream<UserProfile?> watchUserById(String uid) => const Stream.empty();

  @override
  Future<UserProfile?> getUserById(String uid) async => null;

  @override
  Future<void> updateProfile(UserProfile profile) async {}

  @override
  Future<void> updateStatus(String uid, UserStatus status) async {}
}

Widget _buildPage({UserProfile? profile}) {
  return ProviderScope(
    overrides: [
      userRepositoryProvider.overrideWithValue(
        _FakeUserRepository(profile: profile),
      ),
    ],
    child: const MaterialApp(home: HomePage()),
  );
}

void main() {
  group('HomePage', () {
    testWidgets('exibe "CheckIn" na AppBar', (tester) async {
      await tester.pumpWidget(_buildPage());
      expect(find.text('CheckIn'), findsOneWidget);
    });

    testWidgets('exibe ícone de configurações', (tester) async {
      await tester.pumpWidget(_buildPage());
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('exibe nome do usuário quando perfil carregado', (
      tester,
    ) async {
      const profile = UserProfile(
        uid: 'u1',
        displayName: 'João Silva',
        email: 'joao@example.com',
        status: UserStatus.online,
      );
      await tester.pumpWidget(_buildPage(profile: profile));
      await tester.pump();

      expect(find.text('João Silva'), findsOneWidget);
    });

    testWidgets('exibe email do usuário quando perfil carregado', (
      tester,
    ) async {
      const profile = UserProfile(
        uid: 'u1',
        displayName: 'Alice',
        email: 'alice@example.com',
        status: UserStatus.offline,
      );
      await tester.pumpWidget(_buildPage(profile: profile));
      await tester.pump();

      expect(find.text('alice@example.com'), findsOneWidget);
    });

    testWidgets('exibe iniciais no avatar', (tester) async {
      const profile = UserProfile(
        uid: 'u1',
        displayName: 'João Silva',
        email: 'joao@example.com',
        status: UserStatus.online,
      );
      await tester.pumpWidget(_buildPage(profile: profile));
      await tester.pump();

      expect(find.text('JS'), findsOneWidget);
    });

    testWidgets('exibe atalho para Meus locais', (tester) async {
      await tester.pumpWidget(_buildPage());
      expect(find.text('Meus locais'), findsOneWidget);
    });

    testWidgets('exibe atalho para Grupos', (tester) async {
      await tester.pumpWidget(_buildPage());
      expect(find.text('Grupos'), findsOneWidget);
    });
  });
}
