import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/repositories/check_in_repository.dart';

class WatchGeofenceEvents {
  const WatchGeofenceEvents(this._repository);

  final CheckInRepository _repository;

  Stream<List<CheckInEvent>> call(String placeId, {int limit = 50}) =>
      _repository.watchEventsForPlace(placeId, limit: limit);
}
