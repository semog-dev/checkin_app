import 'package:domain/src/entities/geofence_zone.dart';

abstract interface class GeofenceRepository {
  Future<List<GeofenceZone>> getZonesForUser(String userId);
  Future<void> upsertZone(GeofenceZone zone);
  Future<void> deleteZone(String id);
}
