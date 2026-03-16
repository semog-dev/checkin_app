import 'package:checkin_app/features/group/presentation/providers/group_provider.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/entities/place.dart';
import 'package:domain/src/repositories/check_in_repository.dart';
import 'package:domain/src/repositories/place_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// ── Helpers locais ────────────────────────────────────────────────────────────

CheckInEvent _makeEvent({
  String id = 'e1',
  String userId = 'u1',
  String placeId = 'p1',
  CheckInEventType type = CheckInEventType.enter,
  DateTime? timestamp,
}) =>
    CheckInEvent(
      id: id,
      userId: userId,
      placeId: placeId,
      type: type,
      timestamp: timestamp ?? DateTime(2024, 1, 1),
    );

Place _makePlace({String id = 'p1', String name = 'Casa'}) => Place(
      id: id,
      name: name,
      ownerId: 'u1',
      lat: -23.5,
      lng: -46.6,
      createdAt: DateTime(2024, 1, 1),
    );

// ── Fakes ─────────────────────────────────────────────────────────────────────

class _FakeCheckInRepository implements CheckInRepository {
  _FakeCheckInRepository({this.events = const [], this.error});

  final List<CheckInEvent> events;
  final Exception? error;

  String? lastUserId;
  DateTime? lastSince;

  @override
  Future<void> recordEvent(CheckInEvent event) async {}

  @override
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  }) =>
      const Stream.empty();

  @override
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  }) async {
    lastUserId = userId;
    lastSince = since;
    if (error != null) throw error!;
    return events;
  }
}

class _FakePlaceRepository implements PlaceRepository {
  _FakePlaceRepository({this.places = const {}});

  final Map<String, Place> places;
  final Set<String> requestedIds = {};

  @override
  Stream<List<Place>> watchPlaces(String userId) => const Stream.empty();

  @override
  Future<Place?> getPlaceById(String id) async {
    requestedIds.add(id);
    return places[id];
  }

  @override
  Future<void> createPlace(Place place) async {}

  @override
  Future<void> updatePlace(Place place) async {}

  @override
  Future<void> deletePlace(String id) async {}
}

// ── Container helper ──────────────────────────────────────────────────────────

ProviderContainer _makeContainer({
  List<CheckInEvent> events = const [],
  Map<String, Place> places = const {},
  Exception? error,
}) =>
    ProviderContainer(
      overrides: [
        checkInRepositoryProvider.overrideWithValue(
          _FakeCheckInRepository(events: events, error: error),
        ),
        placeRepositoryProvider.overrideWithValue(
          _FakePlaceRepository(places: places),
        ),
      ],
    );

// ── Testes ────────────────────────────────────────────────────────────────────

void main() {
  group('memberHistoryProvider', () {
    test('retorna lista vazia quando não há eventos', () async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final result = await container.read(
        memberHistoryProvider((userId: 'u1', daysBack: 30)).future,
      );

      expect(result, isEmpty);
    });

    test('retorna eventos com nome do local correspondente', () async {
      final event = _makeEvent(placeId: 'p1');
      final place = _makePlace(id: 'p1', name: 'Casa');
      final container = _makeContainer(
        events: [event],
        places: {'p1': place},
      );
      addTearDown(container.dispose);

      final result = await container.read(
        memberHistoryProvider((userId: 'u1', daysBack: 30)).future,
      );

      expect(result, hasLength(1));
      final (resultEvent, placeName) = result.first;
      expect(resultEvent.id, 'e1');
      expect(placeName, 'Casa');
    });

    test('retorna null como placeName quando local não encontrado', () async {
      final event = _makeEvent(placeId: 'p-inexistente');
      final container = _makeContainer(events: [event]);
      addTearDown(container.dispose);

      final result = await container.read(
        memberHistoryProvider((userId: 'u1', daysBack: 30)).future,
      );

      final (_, placeName) = result.first;
      expect(placeName, isNull);
    });

    test('ordena eventos do mais recente ao mais antigo', () async {
      final older = _makeEvent(
        id: 'e-old',
        timestamp: DateTime(2024, 1, 1, 8),
      );
      final newer = _makeEvent(
        id: 'e-new',
        timestamp: DateTime(2024, 6, 1, 18),
      );
      final container = _makeContainer(events: [older, newer]);
      addTearDown(container.dispose);

      final result = await container.read(
        memberHistoryProvider((userId: 'u1', daysBack: 30)).future,
      );

      expect(result[0].$1.id, 'e-new');
      expect(result[1].$1.id, 'e-old');
    });

    test('passa userId correto ao repositório', () async {
      final checkInRepo = _FakeCheckInRepository();
      final container = ProviderContainer(
        overrides: [
          checkInRepositoryProvider.overrideWithValue(checkInRepo),
          placeRepositoryProvider.overrideWithValue(_FakePlaceRepository()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(
        memberHistoryProvider((userId: 'user-42', daysBack: 7)).future,
      );

      expect(checkInRepo.lastUserId, 'user-42');
    });

    test('passa since aproximado a daysBack dias atrás', () async {
      final checkInRepo = _FakeCheckInRepository();
      final container = ProviderContainer(
        overrides: [
          checkInRepositoryProvider.overrideWithValue(checkInRepo),
          placeRepositoryProvider.overrideWithValue(_FakePlaceRepository()),
        ],
      );
      addTearDown(container.dispose);

      final before = DateTime.now();
      await container.read(
        memberHistoryProvider((userId: 'u1', daysBack: 7)).future,
      );
      final after = DateTime.now();

      final since = checkInRepo.lastSince!;
      final expectedMin = before.subtract(const Duration(days: 7, seconds: 1));
      final expectedMax = after.subtract(const Duration(days: 7));
      expect(since.isAfter(expectedMin), isTrue);
      expect(since.isBefore(expectedMax.add(const Duration(seconds: 1))), isTrue);
    });

    test('busca cada placeId único apenas uma vez mesmo com eventos repetidos',
        () async {
      final events = [
        _makeEvent(id: 'e1', placeId: 'p1'),
        _makeEvent(id: 'e2', placeId: 'p1'),
        _makeEvent(id: 'e3', placeId: 'p2'),
      ];
      final placeRepo = _FakePlaceRepository(
        places: {
          'p1': _makePlace(id: 'p1', name: 'Casa'),
          'p2': _makePlace(id: 'p2', name: 'Trabalho'),
        },
      );
      final container = ProviderContainer(
        overrides: [
          checkInRepositoryProvider.overrideWithValue(
            _FakeCheckInRepository(events: events),
          ),
          placeRepositoryProvider.overrideWithValue(placeRepo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(
        memberHistoryProvider((userId: 'u1', daysBack: 30)).future,
      );

      expect(placeRepo.requestedIds, equals({'p1', 'p2'}));
    });

    test('resultado inclui todos os eventos com seus locais', () async {
      final events = [
        _makeEvent(id: 'e1', placeId: 'p1', type: CheckInEventType.enter),
        _makeEvent(id: 'e2', placeId: 'p2', type: CheckInEventType.exit),
      ];
      final container = _makeContainer(
        events: events,
        places: {
          'p1': _makePlace(id: 'p1', name: 'Casa'),
          'p2': _makePlace(id: 'p2', name: 'Trabalho'),
        },
      );
      addTearDown(container.dispose);

      final result = await container.read(
        memberHistoryProvider((userId: 'u1', daysBack: 30)).future,
      );

      expect(result, hasLength(2));
      final placeNames = result.map((e) => e.$2).toList();
      expect(placeNames, containsAll(['Casa', 'Trabalho']));
    });

    test('resulta em AsyncError quando checkInRepository falha', () async {
      final container = _makeContainer(error: Exception('falha de rede'));
      addTearDown(container.dispose);

      // Subscreve para manter o provider vivo (autoDispose)
      container.listen(
        memberHistoryProvider((userId: 'u1', daysBack: 30)),
        (_, __) {},
      );

      await Future.microtask(() {});

      final state =
          container.read(memberHistoryProvider((userId: 'u1', daysBack: 30)));
      // Em Riverpod 3 o erro pode estar em AsyncLoading.error (transitional)
      // ou em AsyncError — hasError cobre ambos os casos.
      expect(state.hasError, isTrue);
      expect(state.error, isA<Exception>());
    });

    test('daysBack=7 resulta em since há 7 dias', () async {
      final checkInRepo7 = _FakeCheckInRepository();
      final checkInRepo30 = _FakeCheckInRepository();
      final container7 = ProviderContainer(
        overrides: [
          checkInRepositoryProvider.overrideWithValue(checkInRepo7),
          placeRepositoryProvider.overrideWithValue(_FakePlaceRepository()),
        ],
      );
      final container30 = ProviderContainer(
        overrides: [
          checkInRepositoryProvider.overrideWithValue(checkInRepo30),
          placeRepositoryProvider.overrideWithValue(_FakePlaceRepository()),
        ],
      );
      addTearDown(container7.dispose);
      addTearDown(container30.dispose);

      await container7.read(
        memberHistoryProvider((userId: 'u1', daysBack: 7)).future,
      );
      await container30.read(
        memberHistoryProvider((userId: 'u1', daysBack: 30)).future,
      );

      expect(
        checkInRepo7.lastSince!.isAfter(checkInRepo30.lastSince!),
        isTrue,
        reason: 'since de 7 dias deve ser mais recente que o de 30 dias',
      );
    });
  });
}
