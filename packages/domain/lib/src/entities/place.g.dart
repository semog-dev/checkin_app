// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Place _$PlaceFromJson(Map<String, dynamic> json) => _Place(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      description: json['description'] as String?,
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      category: $enumDecodeNullable(_$PlaceCategoryEnumMap, json['category']) ??
          PlaceCategory.other,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PlaceToJson(_Place instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ownerId': instance.ownerId,
      'lat': instance.lat,
      'lng': instance.lng,
      'description': instance.description,
      'memberIds': instance.memberIds,
      'category': _$PlaceCategoryEnumMap[instance.category]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$PlaceCategoryEnumMap = {
  PlaceCategory.home: 'home',
  PlaceCategory.work: 'work',
  PlaceCategory.gym: 'gym',
  PlaceCategory.restaurant: 'restaurant',
  PlaceCategory.shop: 'shop',
  PlaceCategory.other: 'other',
};
