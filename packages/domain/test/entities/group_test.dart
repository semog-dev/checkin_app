import 'package:domain/src/entities/group.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';

void main() {
  group('Group', () {
    group('construtor', () {
      test('cria com campos obrigatórios', () {
        final group = makeGroup();

        expect(group.id, 'group-1');
        expect(group.name, 'Família');
        expect(group.adminId, 'user-1');
        expect(group.inviteCode, 'ABC123');
        expect(group.createdAt, kTestDate);
      });

      test('aplica valores padrão', () {
        final group = Group(
          id: 'g1',
          name: 'Teste',
          adminId: 'u1',
          inviteCode: 'XYZ',
          createdAt: kTestDate,
        );

        expect(group.memberIds, isEmpty);
        expect(group.placeIds, isEmpty);
      });

      test('aceita todos os campos opcionais', () {
        final group = makeGroup(
          memberIds: ['u1', 'u2', 'u3'],
          placeIds: ['p1', 'p2'],
        );

        expect(group.memberIds, ['u1', 'u2', 'u3']);
        expect(group.placeIds, ['p1', 'p2']);
      });
    });

    group('igualdade', () {
      test('dois objetos com mesmos dados são iguais', () {
        expect(makeGroup(), equals(makeGroup()));
      });

      test('objetos com ids diferentes não são iguais', () {
        final a = makeGroup(id: 'g1');
        final b = makeGroup(id: 'g2');
        expect(a, isNot(equals(b)));
      });

      test('objetos com inviteCodes diferentes não são iguais', () {
        final a = makeGroup(inviteCode: 'AAA');
        final b = makeGroup(inviteCode: 'BBB');
        expect(a, isNot(equals(b)));
      });

      test('hashCode é consistente para objetos iguais', () {
        expect(makeGroup().hashCode, equals(makeGroup().hashCode));
      });
    });

    group('copyWith', () {
      test('altera campos especificados mantendo os demais', () {
        final original = makeGroup(name: 'Antigo');
        final updated = original.copyWith(name: 'Novo', inviteCode: 'NEW123');

        expect(updated.name, 'Novo');
        expect(updated.inviteCode, 'NEW123');
        expect(updated.id, original.id);
        expect(updated.adminId, original.adminId);
      });

      test('copyWith sem argumentos retorna objeto igual', () {
        final original = makeGroup();
        expect(original.copyWith(), equals(original));
      });

      test('pode adicionar membros via copyWith', () {
        final original = makeGroup(memberIds: ['u1']);
        final updated =
            original.copyWith(memberIds: [...original.memberIds, 'u2']);
        expect(updated.memberIds, ['u1', 'u2']);
      });
    });

    group('serialização JSON', () {
      test('toJson/fromJson — roundtrip completo', () {
        final group = makeGroup(
          memberIds: ['u1', 'u2'],
          placeIds: ['p1'],
        );

        final restored = Group.fromJson(group.toJson());
        expect(restored, equals(group));
      });

      test('toJson inclui todos os campos', () {
        final group = makeGroup();
        final json = group.toJson();

        expect(json['id'], 'group-1');
        expect(json['name'], 'Família');
        expect(json['adminId'], 'user-1');
        expect(json['inviteCode'], 'ABC123');
        expect(json.containsKey('memberIds'), isTrue);
        expect(json.containsKey('placeIds'), isTrue);
        expect(json.containsKey('createdAt'), isTrue);
      });

      test('fromJson com campos mínimos aplica padrões', () {
        final json = <String, dynamic>{
          'id': 'g1',
          'name': 'X',
          'adminId': 'u1',
          'inviteCode': 'ABC',
          'createdAt': kTestDate.toIso8601String(),
        };

        final group = Group.fromJson(json);
        expect(group.memberIds, isEmpty);
        expect(group.placeIds, isEmpty);
      });
    });
  });
}
