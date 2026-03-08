// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.offline,
      groupIds: (json['groupIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
      currentPlaceId: json['currentPlaceId'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'status': _$UserStatusEnumMap[instance.status]!,
      'groupIds': instance.groupIds,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
      'currentPlaceId': instance.currentPlaceId,
    };

const _$UserStatusEnumMap = {
  UserStatus.online: 'online',
  UserStatus.offline: 'offline',
  UserStatus.busy: 'busy',
  UserStatus.away: 'away',
};
