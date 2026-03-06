import 'package:domain/src/entities/place.dart';
import 'package:domain/src/repositories/place_repository.dart';

class CreatePlace {
  const CreatePlace(this._repository);

  final PlaceRepository _repository;

  Future<void> call(Place place) => _repository.createPlace(place);
}
