import 'package:freezed_annotation/freezed_annotation.dart';

part 'geofence_zone.freezed.dart';
part 'geofence_zone.g.dart';

@freezed
abstract class GeofenceZone with _$GeofenceZone {
  const factory GeofenceZone({
    required String id,
    required String placeId,
    required double lat,
    required double lng,
    @Default(100.0) double radiusMeters,
    @Default(true) bool isActive,
  }) = _GeofenceZone;

  factory GeofenceZone.fromJson(Map<String, dynamic> json) =>
      _$GeofenceZoneFromJson(json);
}
