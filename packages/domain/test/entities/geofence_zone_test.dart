import 'package:domain/src/entities/geofence_zone.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';

void main() {
  group('GeofenceZone', () {
    group('construtor', () {
      test('cria com campos obrigatórios', () {
        final zone = makeGeofenceZone();

        expect(zone.id, 'zone-1');
        expect(zone.placeId, 'place-1');
        expect(zone.lat, -23.5505);
        expect(zone.lng, -46.6333);
      });

      test('aplica valores padrão', () {
        final zone = GeofenceZone(
          id: 'z1',
          placeId: 'p1',
          lat: 0,
          lng: 0,
        );

        expect(zone.radiusMeters, 100.0);
        expect(zone.isActive, isTrue);
      });

      test('aceita raio e status personalizados', () {
        final zone = makeGeofenceZone(radiusMeters: 250.0, isActive: false);

        expect(zone.radiusMeters, 250.0);
        expect(zone.isActive, isFalse);
      });

      test('aceita raio mínimo de 1 metro', () {
        final zone = makeGeofenceZone(radiusMeters: 1.0);
        expect(zone.radiusMeters, 1.0);
      });

      test('aceita raio grande (>1km)', () {
        final zone = makeGeofenceZone(radiusMeters: 5000.0);
        expect(zone.radiusMeters, 5000.0);
      });
    });

    group('igualdade', () {
      test('dois objetos com mesmos dados são iguais', () {
        expect(makeGeofenceZone(), equals(makeGeofenceZone()));
      });

      test('objetos com ids diferentes não são iguais', () {
        final a = makeGeofenceZone(id: 'z1');
        final b = makeGeofenceZone(id: 'z2');
        expect(a, isNot(equals(b)));
      });

      test('objetos com raios diferentes não são iguais', () {
        final a = makeGeofenceZone(radiusMeters: 100.0);
        final b = makeGeofenceZone(radiusMeters: 200.0);
        expect(a, isNot(equals(b)));
      });

      test('objeto ativo e inativo não são iguais', () {
        final a = makeGeofenceZone(isActive: true);
        final b = makeGeofenceZone(isActive: false);
        expect(a, isNot(equals(b)));
      });

      test('hashCode é consistente para objetos iguais', () {
        expect(
          makeGeofenceZone().hashCode,
          equals(makeGeofenceZone().hashCode),
        );
      });
    });

    group('copyWith', () {
      test('pode desativar zona', () {
        final zone = makeGeofenceZone(isActive: true);
        final deactivated = zone.copyWith(isActive: false);

        expect(deactivated.isActive, isFalse);
        expect(deactivated.id, zone.id);
      });

      test('pode atualizar raio', () {
        final zone = makeGeofenceZone(radiusMeters: 100.0);
        final updated = zone.copyWith(radiusMeters: 300.0);

        expect(updated.radiusMeters, 300.0);
      });

      test('pode mover coordenadas', () {
        final zone = makeGeofenceZone(lat: -23.0, lng: -46.0);
        final moved = zone.copyWith(lat: -22.0, lng: -45.0);

        expect(moved.lat, -22.0);
        expect(moved.lng, -45.0);
        expect(moved.id, zone.id);
      });

      test('copyWith sem argumentos retorna objeto igual', () {
        final zone = makeGeofenceZone();
        expect(zone.copyWith(), equals(zone));
      });
    });

    group('serialização JSON', () {
      test('toJson/fromJson — roundtrip completo', () {
        final zone = makeGeofenceZone(radiusMeters: 150.0, isActive: false);
        final restored = GeofenceZone.fromJson(zone.toJson());
        expect(restored, equals(zone));
      });

      test('toJson inclui todos os campos', () {
        final zone = makeGeofenceZone();
        final json = zone.toJson();

        expect(json['id'], 'zone-1');
        expect(json['placeId'], 'place-1');
        expect(json['lat'], -23.5505);
        expect(json['lng'], -46.6333);
        expect(json['radiusMeters'], 100.0);
        expect(json['isActive'], isTrue);
      });

      test('fromJson com campos mínimos aplica padrões', () {
        final json = <String, dynamic>{
          'id': 'z1',
          'placeId': 'p1',
          'lat': 0.0,
          'lng': 0.0,
        };

        final zone = GeofenceZone.fromJson(json);
        expect(zone.radiusMeters, 100.0);
        expect(zone.isActive, isTrue);
      });
    });
  });
}
