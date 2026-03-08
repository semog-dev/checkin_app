import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/src/entities/place.dart';
import 'package:domain/src/repositories/place_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Place _makePlace({String id = 'p1', String name = 'Casa'}) => Place(
      id: id,
      name: name,
      ownerId: 'user-1',
      lat: -23.5505,
      lng: -46.6333,
      createdAt: DateTime(2024, 6, 15),
    );

class _FakePlaceRepository implements PlaceRepository {
  List<Place> placesToEmit = [];
  Place? lastCreatedPlace;
  Place? lastUpdatedPlace;
  String? lastDeletedId;
  Exception? errorToThrow;

  @override
  Stream<List<Place>> watchPlaces(String userId) {
    if (errorToThrow != null) return Stream.error(errorToThrow!);
    return Stream.value(placesToEmit);
  }

  @override
  Future<Place?> getPlaceById(String id) async => null;

  @override
  Future<void> createPlace(Place place) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastCreatedPlace = place;
  }

  @override
  Future<void> updatePlace(Place place) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastUpdatedPlace = place;
  }

  @override
  Future<void> deletePlace(String id) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastDeletedId = id;
  }
}

ProviderContainer _makeContainer(
  _FakePlaceRepository repo, {
  String userId = 'user-1',
}) {
  final container = ProviderContainer(
    overrides: [
      placeRepositoryProvider.overrideWithValue(repo),
      currentUserIdProvider.overrideWithValue(userId),
    ],
  );
  // Eager init: aciona o build() para que a stream já esteja subscrita
  // antes de qualquer await no teste.
  container.read(placesNotifierProvider);
  return container;
}

void main() {
  group('PlacesNotifier', () {
    test('estado inicial é PlacesState.loading()', () {
      final container = _makeContainer(_FakePlaceRepository());
      addTearDown(container.dispose);

      expect(
        container.read(placesNotifierProvider),
        const PlacesState.loading(),
      );
    });

    test('carrega lista de locais do repositório', () async {
      final places = [_makePlace(), _makePlace(id: 'p2', name: 'Trabalho')];
      final repo = _FakePlaceRepository()..placesToEmit = places;
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await Future.microtask(() {});

      final state = container.read(placesNotifierProvider);
      expect(state, isA<PlacesLoaded>());
      expect((state as PlacesLoaded).places, equals(places));
    });

    test('torna-se error quando repositório falha', () async {
      final repo = _FakePlaceRepository()
        ..errorToThrow = Exception('sem conexão');
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await Future.microtask(() {});

      expect(container.read(placesNotifierProvider), isA<PlacesError>());
    });

    test('lista vazia resulta em PlacesLoaded com lista vazia', () async {
      final repo = _FakePlaceRepository()..placesToEmit = [];
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await Future.microtask(() {});

      final state = container.read(placesNotifierProvider);
      expect(state, isA<PlacesLoaded>());
      expect((state as PlacesLoaded).places, isEmpty);
    });

    test('createPlace chama repositório com local correto', () async {
      final repo = _FakePlaceRepository();
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      final place = _makePlace();
      await container.read(placesNotifierProvider.notifier).createPlace(place);

      expect(repo.lastCreatedPlace, equals(place));
    });

    test('deletePlace chama repositório com id correto', () async {
      final repo = _FakePlaceRepository()..placesToEmit = [_makePlace()];
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await container.read(placesNotifierProvider.notifier).deletePlace('p1');

      expect(repo.lastDeletedId, 'p1');
    });

    test('createPlace com erro resulta em PlacesError', () async {
      final repo = _FakePlaceRepository()
        ..errorToThrow = Exception('falha ao criar');
      final container = _makeContainer(repo);
      addTearDown(container.dispose);

      await container
          .read(placesNotifierProvider.notifier)
          .createPlace(_makePlace());

      expect(container.read(placesNotifierProvider), isA<PlacesError>());
    });
  });
}
