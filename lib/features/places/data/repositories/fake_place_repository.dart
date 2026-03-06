import 'dart:async';

import 'package:domain/domain.dart';

/// Implementação fake em memória usada antes do Firestore ser configurado.
class FakePlaceRepository implements PlaceRepository {
  final _store = <String, Place>{};
  final _controller = StreamController<List<Place>>.broadcast();

  void _emit() => _controller.add(_store.values.toList());

  @override
  Stream<List<Place>> watchPlaces(String userId) async* {
    yield _store.values.where((p) => p.ownerId == userId).toList();
    yield* _controller.stream.map(
      (all) => all.where((p) => p.ownerId == userId).toList(),
    );
  }

  @override
  Future<Place?> getPlaceById(String id) async => _store[id];

  @override
  Future<void> createPlace(Place place) async {
    _store[place.id] = place;
    _emit();
  }

  @override
  Future<void> updatePlace(Place place) async {
    _store[place.id] = place;
    _emit();
  }

  @override
  Future<void> deletePlace(String id) async {
    _store.remove(id);
    _emit();
  }
}
