import 'package:checkin_app/features/places/presentation/pages/place_detail_page.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _testPlace = Place(
  id: 'p1',
  name: 'Escritório',
  ownerId: 'u1',
  lat: -23.55,
  lng: -46.63,
  category: PlaceCategory.work,
  createdAt: DateTime(2024),
);

class _FakePlaceRepository implements PlaceRepository {
  @override
  Stream<List<Place>> watchPlaces(String userId) =>
      Stream.value([_testPlace]);

  @override
  Future<Place?> getPlaceById(String id) async => _testPlace;

  @override
  Future<void> createPlace(Place place) async {}

  @override
  Future<void> updatePlace(Place place) async {}

  @override
  Future<void> deletePlace(String id) async {}
}

class _FakeCheckInRepository implements CheckInRepository {
  final List<CheckInEvent> events;

  _FakeCheckInRepository({this.events = const []});

  @override
  Future<void> recordEvent(CheckInEvent event) async {}

  @override
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  }) =>
      Stream.value(events);

  @override
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  }) async =>
      [];
}

Widget _buildPage({List<CheckInEvent> events = const []}) {
  return ProviderScope(
    overrides: [
      currentUserIdProvider.overrideWithValue('u1'),
      placeRepositoryProvider.overrideWithValue(_FakePlaceRepository()),
      checkInRepositoryProvider
          .overrideWithValue(_FakeCheckInRepository(events: events)),
    ],
    child: MaterialApp(
      home: PlaceDetailPage(placeId: _testPlace.id),
    ),
  );
}

void main() {
  group('PlaceDetailPage', () {
    testWidgets('exibe nome do local na AppBar', (tester) async {
      await tester.pumpWidget(_buildPage());
      await tester.pump();
      expect(find.text('Escritório'), findsWidgets);
    });

    testWidgets('exibe chip de categoria', (tester) async {
      await tester.pumpWidget(_buildPage());
      await tester.pump();
      expect(find.text('work'), findsOneWidget);
    });

    testWidgets('exibe mensagem quando não há check-ins', (tester) async {
      await tester.pumpWidget(_buildPage());
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Nenhum check-in registrado'), findsOneWidget);
    });

    testWidgets('exibe evento de entrada na lista', (tester) async {
      final events = [
        CheckInEvent(
          id: 'e1',
          userId: 'u1',
          placeId: 'p1',
          type: CheckInEventType.enter,
          timestamp: DateTime(2024, 3, 1, 10, 30),
        ),
      ];
      await tester.pumpWidget(_buildPage(events: events));
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Entrada'), findsOneWidget);
    });

    testWidgets('exibe evento de saída na lista', (tester) async {
      final events = [
        CheckInEvent(
          id: 'e2',
          userId: 'u1',
          placeId: 'p1',
          type: CheckInEventType.exit,
          timestamp: DateTime(2024, 3, 1, 11, 0),
        ),
      ];
      await tester.pumpWidget(_buildPage(events: events));
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Saída'), findsOneWidget);
    });

    testWidgets('exibe título do histórico', (tester) async {
      await tester.pumpWidget(_buildPage());
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Histórico de check-ins'), findsOneWidget);
    });
  });
}
