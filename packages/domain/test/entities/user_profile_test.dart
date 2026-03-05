import 'package:domain/src/entities/user_profile.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';

void main() {
  group('UserProfile', () {
    group('construtor', () {
      test('cria com campos obrigatórios', () {
        final profile = makeUserProfile();

        expect(profile.uid, 'user-1');
        expect(profile.displayName, 'Alice');
        expect(profile.email, 'alice@example.com');
      });

      test('aplica valores padrão', () {
        final profile = makeUserProfile();

        expect(profile.photoUrl, isNull);
        expect(profile.status, UserStatus.online);
        expect(profile.groupIds, isEmpty);
        expect(profile.lastSeenAt, isNull);
      });

      test('aceita todos os campos opcionais', () {
        final profile = makeUserProfile(
          photoUrl: 'https://example.com/photo.jpg',
          status: UserStatus.busy,
          groupIds: ['g1', 'g2'],
          lastSeenAt: kTestDate,
        );

        expect(profile.photoUrl, 'https://example.com/photo.jpg');
        expect(profile.status, UserStatus.busy);
        expect(profile.groupIds, ['g1', 'g2']);
        expect(profile.lastSeenAt, kTestDate);
      });
    });

    group('igualdade', () {
      test('dois objetos com mesmos dados são iguais', () {
        final a = makeUserProfile();
        final b = makeUserProfile();

        expect(a, equals(b));
      });

      test('objetos com uids diferentes não são iguais', () {
        final a = makeUserProfile(uid: 'user-1');
        final b = makeUserProfile(uid: 'user-2');

        expect(a, isNot(equals(b)));
      });

      test('objetos com status diferentes não são iguais', () {
        final a = makeUserProfile(status: UserStatus.online);
        final b = makeUserProfile(status: UserStatus.offline);

        expect(a, isNot(equals(b)));
      });

      test('hashCode é consistente para objetos iguais', () {
        final a = makeUserProfile();
        final b = makeUserProfile();

        expect(a.hashCode, b.hashCode);
      });
    });

    group('copyWith', () {
      test('altera campos especificados mantendo os demais', () {
        final original = makeUserProfile(status: UserStatus.offline);
        final updated = original.copyWith(
          displayName: 'Alice S.',
          status: UserStatus.online,
        );

        expect(updated.displayName, 'Alice S.');
        expect(updated.status, UserStatus.online);
        expect(updated.uid, original.uid);
        expect(updated.email, original.email);
      });

      test('copyWith sem argumentos retorna objeto igual', () {
        final original = makeUserProfile();
        expect(original.copyWith(), equals(original));
      });

      test('pode setar lastSeenAt', () {
        final original = makeUserProfile();
        final updated = original.copyWith(lastSeenAt: kTestDate);

        expect(updated.lastSeenAt, kTestDate);
      });
    });

    group('serialização JSON', () {
      test('toJson/fromJson — roundtrip completo', () {
        final profile = makeUserProfile(
          photoUrl: 'https://example.com/photo.jpg',
          status: UserStatus.away,
          groupIds: ['g1'],
          lastSeenAt: kTestDate,
        );

        final restored = UserProfile.fromJson(profile.toJson());
        expect(restored, equals(profile));
      });

      test('fromJson com campos mínimos aplica padrões', () {
        final json = <String, dynamic>{
          'uid': 'u1',
          'displayName': 'Bob',
          'email': 'bob@example.com',
        };

        final profile = UserProfile.fromJson(json);
        expect(profile.status, UserStatus.offline);
        expect(profile.groupIds, isEmpty);
        expect(profile.photoUrl, isNull);
        expect(profile.lastSeenAt, isNull);
      });

      test('fromJson preserva todos os status', () {
        for (final status in UserStatus.values) {
          final json = <String, dynamic>{
            'uid': 'u1',
            'displayName': 'Bob',
            'email': 'bob@example.com',
            'status': status.name,
          };
          expect(UserProfile.fromJson(json).status, status);
        }
      });
    });

    group('UserStatus', () {
      test('contém todos os status esperados', () {
        expect(
          UserStatus.values,
          containsAll([
            UserStatus.online,
            UserStatus.offline,
            UserStatus.busy,
            UserStatus.away,
          ]),
        );
      });

      test('total de 4 status', () {
        expect(UserStatus.values.length, 4);
      });
    });
  });
}
