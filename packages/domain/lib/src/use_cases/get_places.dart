import 'package:domain/src/entities/place.dart';
import 'package:domain/src/repositories/place_repository.dart';

class GetPlaces {
  const GetPlaces(this._repository);

  final PlaceRepository _repository;

  Stream<List<Place>> call(String userId) => _repository.watchPlaces(userId);
}
