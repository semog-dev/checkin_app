import 'package:core/core.dart';
import 'package:domain/domain.dart';

/// Simple in-memory implementation of [CheckInRepository].
/// Stores events in a list and exposes them via streams.
/// Suitable for local use while the Firestore implementation is not ready.
class InMemoryCheckInRepository implements CheckInRepository {
  final List<CheckInEvent> _events = [];

  @override
  Future<void> recordEvent(CheckInEvent event) async {
    _events.add(event);
    AppLogger.i('[CheckIn] ${event.type.name} → place ${event.placeId}');
  }

  @override
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  }) async* {
    yield _events.where((e) => e.placeId == placeId).take(limit).toList();
  }

  @override
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  }) async {
    return _events
        .where(
          (e) => e.userId == userId && e.timestamp.isAfter(since),
        )
        .toList();
  }
}
