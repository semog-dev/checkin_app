import 'package:checkin_app/features/geofencing/data/services/geofence_service.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

Position _pos(double lat, double lng, {double accuracy = 5.0}) => Position(
      latitude: lat,
      longitude: lng,
      accuracy: accuracy,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
      timestamp: DateTime.now(),
    );

GeofenceZone _zone({
  String id = 'z1',
  String placeId = 'p1',
  double lat = -23.5505,
  double lng = -46.6333,
  double radius = 100.0,
}) =>
    GeofenceZone(id: id, placeId: placeId, lat: lat, lng: lng, radiusMeters: radius);

const _userId = 'user-1';

void main() {
  group('GeofenceService.distanceMeters', () {
    test('retorna 0 para mesma posição', () {
      final d = GeofenceService.distanceMeters(-23.55, -46.63, -23.55, -46.63);
      expect(d, closeTo(0.0, 0.001));
    });

    test('calcula distância conhecida entre dois pontos', () {
      // Distância aproximada entre (-23.55, -46.63) e (-23.56, -46.63)
      // ≈ 1112 metros (1 grau de latitude ≈ 111.2 km)
      final d = GeofenceService.distanceMeters(
        -23.55,
        -46.63,
        -23.56,
        -46.63,
      );
      expect(d, closeTo(1112.0, 20.0));
    });

    test('é simétrico', () {
      final d1 = GeofenceService.distanceMeters(-23.55, -46.63, -23.56, -46.64);
      final d2 = GeofenceService.distanceMeters(-23.56, -46.64, -23.55, -46.63);
      expect(d1, closeTo(d2, 0.001));
    });
  });

  group('GeofenceService.watchCrossings', () {
    final service = GeofenceService();

    test('emite evento enter ao entrar na zona', () async {
      final zones = [_zone(radius: 200)];
      // Posição dentro da zona (mesma lat/lng do centro)
      final positions = Stream.fromIterable([
        _pos(-23.5505, -46.6333),
      ]);

      final events = await service
          .watchCrossings(userId: _userId, zones: zones, positionStream: positions)
          .toList();

      expect(events, hasLength(1));
      expect(events.first.type, CheckInEventType.enter);
      expect(events.first.placeId, 'p1');
      expect(events.first.userId, _userId);
    });

    test('emite evento exit ao sair da zona', () async {
      final zones = [_zone(radius: 100)];
      final positions = Stream.fromIterable([
        // Primeiro dentro da zona
        _pos(-23.5505, -46.6333),
        // Depois bem longe (> 100m)
        _pos(-23.5515, -46.6333),
      ]);

      final events = await service
          .watchCrossings(userId: _userId, zones: zones, positionStream: positions)
          .toList();

      expect(events, hasLength(2));
      expect(events[0].type, CheckInEventType.enter);
      expect(events[1].type, CheckInEventType.exit);
    });

    test('não emite eventos redundantes quando já está dentro', () async {
      final zones = [_zone(radius: 200)];
      final positions = Stream.fromIterable([
        // Três posições dentro da mesma zona
        _pos(-23.5505, -46.6333),
        _pos(-23.5506, -46.6334),
        _pos(-23.5504, -46.6332),
      ]);

      final events = await service
          .watchCrossings(userId: _userId, zones: zones, positionStream: positions)
          .toList();

      // Só 1 enter, nenhum exit
      expect(events, hasLength(1));
      expect(events.first.type, CheckInEventType.enter);
    });

    test('não emite eventos quando fora da zona o tempo todo', () async {
      final zones = [_zone(radius: 50)];
      // Posição muito longe do centro da zona
      final positions = Stream.fromIterable([
        _pos(-23.6000, -46.7000),
      ]);

      final events = await service
          .watchCrossings(userId: _userId, zones: zones, positionStream: positions)
          .toList();

      expect(events, isEmpty);
    });

    test('monitora múltiplas zonas independentemente', () async {
      final zones = [
        _zone(id: 'z1', placeId: 'p1', lat: -23.5505, lng: -46.6333, radius: 200),
        _zone(id: 'z2', placeId: 'p2', lat: -23.5600, lng: -46.6400, radius: 200),
      ];
      // Posição dentro de p1 mas longe de p2
      final positions = Stream.fromIterable([
        _pos(-23.5505, -46.6333),
      ]);

      final events = await service
          .watchCrossings(userId: _userId, zones: zones, positionStream: positions)
          .toList();

      expect(events, hasLength(1));
      expect(events.first.placeId, 'p1');
    });

    test('ignora zonas inativas', () async {
      final zones = [
        GeofenceZone(
          id: 'z1',
          placeId: 'p1',
          lat: -23.5505,
          lng: -46.6333,
          isActive: false,
        ),
      ];
      final positions = Stream.fromIterable([
        _pos(-23.5505, -46.6333),
      ]);

      final events = await service
          .watchCrossings(userId: _userId, zones: zones, positionStream: positions)
          .toList();

      expect(events, isEmpty);
    });

    test('inclui accuracyMeters no evento', () async {
      final zones = [_zone(radius: 200)];
      final positions = Stream.fromIterable([
        _pos(-23.5505, -46.6333, accuracy: 12.5),
      ]);

      final events = await service
          .watchCrossings(userId: _userId, zones: zones, positionStream: positions)
          .toList();

      expect(events.first.accuracyMeters, 12.5);
    });

    test('propaga erro do stream de posição', () async {
      final zones = [_zone()];
      final positions = Stream<Position>.error(Exception('GPS indisponível'));

      expect(
        () => service
            .watchCrossings(
              userId: _userId,
              zones: zones,
              positionStream: positions,
            )
            .toList(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
