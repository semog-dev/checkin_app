// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckInEvent _$CheckInEventFromJson(Map<String, dynamic> json) =>
    _CheckInEvent(
      id: json['id'] as String,
      userId: json['userId'] as String,
      placeId: json['placeId'] as String,
      type: $enumDecode(_$CheckInEventTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      accuracyMeters: (json['accuracyMeters'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CheckInEventToJson(_CheckInEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'type': _$CheckInEventTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'accuracyMeters': instance.accuracyMeters,
    };

const _$CheckInEventTypeEnumMap = {
  CheckInEventType.enter: 'enter',
  CheckInEventType.exit: 'exit',
};
