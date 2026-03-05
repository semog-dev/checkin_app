// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Group _$GroupFromJson(Map<String, dynamic> json) => _Group(
      id: json['id'] as String,
      name: json['name'] as String,
      adminId: json['adminId'] as String,
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      placeIds: (json['placeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      inviteCode: json['inviteCode'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GroupToJson(_Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adminId': instance.adminId,
      'memberIds': instance.memberIds,
      'placeIds': instance.placeIds,
      'inviteCode': instance.inviteCode,
      'createdAt': instance.createdAt.toIso8601String(),
    };
