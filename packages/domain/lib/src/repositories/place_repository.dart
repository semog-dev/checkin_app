import 'package:domain/src/entities/place.dart';

abstract interface class PlaceRepository {
  Stream<List<Place>> watchPlaces(String userId);
  Future<Place?> getPlaceById(String id);
  Future<void> createPlace(Place place);
  Future<void> updatePlace(Place place);
  Future<void> deletePlace(String id);
}
