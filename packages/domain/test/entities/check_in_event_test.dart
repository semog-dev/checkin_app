import 'package:domain/src/entities/check_in_event.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';

void main() {
  group('CheckInEvent', () {
    group('construtor', () {
      test('cria com campos obrigatórios', () {
        final event = makeCheckInEvent();

        expect(event.id, 'event-1');
        expect(event.userId, 'user-1');
        expect(event.placeId, 'place-1');
        expect(event.type, CheckInEventType.enter);
        expect(event.timestamp, kTestDate);
      });

      test('accuracyMeters é null por padrão', () {
        final event = makeCheckInEvent();
        expect(event.accuracyMeters, isNull);
      });

      test('aceita accuracyMeters quando fornecido', () {
        final event = makeCheckInEvent(accuracyMeters: 5.5);
        expect(event.accuracyMeters, 5.5);
      });

      test('aceita tipo exit', () {
        final event = makeCheckInEvent(type: CheckInEventType.exit);
        expect(event.type, CheckInEventType.exit);
      });
    });

    group('igualdade', () {
      test('dois objetos com mesmos dados são iguais', () {
        expect(makeCheckInEvent(), equals(makeCheckInEvent()));
      });

      test('objetos com ids diferentes não são iguais', () {
        final a = makeCheckInEvent(id: 'e1');
        final b = makeCheckInEvent(id: 'e2');
        expect(a, isNot(equals(b)));
      });

      test('objetos com tipos diferentes não são iguais', () {
        final a = makeCheckInEvent(type: CheckInEventType.enter);
        final b = makeCheckInEvent(type: CheckInEventType.exit);
        expect(a, isNot(equals(b)));
      });

      test('objetos com accuracyMeters diferentes não são iguais', () {
        final a = makeCheckInEvent(accuracyMeters: 5.0);
        final b = makeCheckInEvent(accuracyMeters: 10.0);
        expect(a, isNot(equals(b)));
      });

      test('hashCode é consistente para objetos iguais', () {
        expect(
          makeCheckInEvent().hashCode,
          equals(makeCheckInEvent().hashCode),
        );
      });
    });

    group('copyWith', () {
      test('altera campos especificados', () {
        final original = makeCheckInEvent(type: CheckInEventType.enter);
        final updated = original.copyWith(type: CheckInEventType.exit);

        expect(updated.type, CheckInEventType.exit);
        expect(updated.id, original.id);
        expect(updated.userId, original.userId);
        expect(updated.placeId, original.placeId);
      });

      test('copyWith sem argumentos retorna objeto igual', () {
        final original = makeCheckInEvent();
        expect(original.copyWith(), equals(original));
      });

      test('pode setar accuracyMeters', () {
        final original = makeCheckInEvent();
        final updated = original.copyWith(accuracyMeters: 8.0);
        expect(updated.accuracyMeters, 8.0);
      });
    });

    group('serialização JSON', () {
      test('toJson/fromJson — roundtrip completo', () {
        final event = makeCheckInEvent(
          type: CheckInEventType.exit,
          accuracyMeters: 3.14,
        );

        final restored = CheckInEvent.fromJson(event.toJson());
        expect(restored, equals(event));
      });

      test('toJson inclui todos os campos', () {
        final event = makeCheckInEvent();
        final json = event.toJson();

        expect(json['id'], 'event-1');
        expect(json['userId'], 'user-1');
        expect(json['placeId'], 'place-1');
        expect(json.containsKey('type'), isTrue);
        expect(json.containsKey('timestamp'), isTrue);
      });

      test('fromJson com accuracyMeters null funciona', () {
        final json = <String, dynamic>{
          'id': 'e1',
          'userId': 'u1',
          'placeId': 'p1',
          'type': 'enter',
          'timestamp': kTestDate.toIso8601String(),
        };

        final event = CheckInEvent.fromJson(json);
        expect(event.accuracyMeters, isNull);
      });

      test('fromJson preserva ambos os tipos de evento', () {
        for (final type in CheckInEventType.values) {
          final json = <String, dynamic>{
            'id': 'e1',
            'userId': 'u1',
            'placeId': 'p1',
            'type': type.name,
            'timestamp': kTestDate.toIso8601String(),
          };
          expect(CheckInEvent.fromJson(json).type, type);
        }
      });
    });

    group('CheckInEventType', () {
      test('contém enter e exit', () {
        expect(
          CheckInEventType.values,
          containsAll([CheckInEventType.enter, CheckInEventType.exit]),
        );
      });

      test('total de 2 tipos', () {
        expect(CheckInEventType.values.length, 2);
      });
    });
  });
}
