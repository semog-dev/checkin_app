import 'dart:math';

import 'package:domain/domain.dart';
import 'package:geolocator/geolocator.dart';

/// Pure service: given a position stream and a list of zones,
/// emits [CheckInEvent]s whenever the user crosses a zone boundary.
///
/// Maintains internal state (which zones are currently inside) per subscription.
class GeofenceService {
  Stream<CheckInEvent> watchCrossings({
    required String userId,
    required List<GeofenceZone> zones,
    required Stream<Position> positionStream,
  }) async* {
    final activeZones = zones.where((z) => z.isActive).toList();
    final insidePlaceIds = <String>{};

    await for (final position in positionStream) {
      for (final zone in activeZones) {
        final distance = distanceMeters(
          position.latitude,
          position.longitude,
          zone.lat,
          zone.lng,
        );

        final wasInside = insidePlaceIds.contains(zone.placeId);
        final isInside = distance <= zone.radiusMeters;

        if (isInside && !wasInside) {
          insidePlaceIds.add(zone.placeId);
          yield CheckInEvent(
            id: '${DateTime.now().millisecondsSinceEpoch}_${zone.placeId}',
            userId: userId,
            placeId: zone.placeId,
            type: CheckInEventType.enter,
            timestamp: DateTime.now(),
            accuracyMeters: position.accuracy,
          );
        } else if (!isInside && wasInside) {
          insidePlaceIds.remove(zone.placeId);
          yield CheckInEvent(
            id: '${DateTime.now().millisecondsSinceEpoch}_${zone.placeId}',
            userId: userId,
            placeId: zone.placeId,
            type: CheckInEventType.exit,
            timestamp: DateTime.now(),
            accuracyMeters: position.accuracy,
          );
        }
      }
    }
  }

  /// Haversine formula — distance in meters between two lat/lng coordinates.
  static double distanceMeters(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371000.0;
    final phi1 = lat1 * pi / 180;
    final phi2 = lat2 * pi / 180;
    final dPhi = (lat2 - lat1) * pi / 180;
    final dLambda = (lon2 - lon1) * pi / 180;

    final a = sin(dPhi / 2) * sin(dPhi / 2) +
        cos(phi1) * cos(phi2) * sin(dLambda / 2) * sin(dLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return r * c;
  }
}
