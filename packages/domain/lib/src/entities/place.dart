import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';
part 'place.g.dart';

enum PlaceCategory { home, work, gym, restaurant, shop, other }

@freezed
class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String ownerId,
    required double lat,
    required double lng,
    String? description,
    @Default([]) List<String> memberIds,
    @Default(PlaceCategory.other) PlaceCategory category,
    required DateTime createdAt,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
