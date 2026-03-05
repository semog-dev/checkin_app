import 'package:domain/src/entities/check_in_event.dart';

abstract interface class CheckInRepository {
  Future<void> recordEvent(CheckInEvent event);
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  });
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  });
}
