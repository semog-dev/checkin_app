// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofence_zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeofenceZone _$GeofenceZoneFromJson(Map<String, dynamic> json) =>
    _GeofenceZone(
      id: json['id'] as String,
      placeId: json['placeId'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      radiusMeters: (json['radiusMeters'] as num?)?.toDouble() ?? 100.0,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$GeofenceZoneToJson(_GeofenceZone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'lat': instance.lat,
      'lng': instance.lng,
      'radiusMeters': instance.radiusMeters,
      'isActive': instance.isActive,
    };
