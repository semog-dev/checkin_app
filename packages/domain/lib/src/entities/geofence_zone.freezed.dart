// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geofence_zone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeofenceZone _$GeofenceZoneFromJson(Map<String, dynamic> json) {
  return _GeofenceZone.fromJson(json);
}

/// @nodoc
mixin _$GeofenceZone {
  String get id => throw _privateConstructorUsedError;
  String get placeId => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  double get radiusMeters => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this GeofenceZone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeofenceZoneCopyWith<GeofenceZone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeofenceZoneCopyWith<$Res> {
  factory $GeofenceZoneCopyWith(
          GeofenceZone value, $Res Function(GeofenceZone) then) =
      _$GeofenceZoneCopyWithImpl<$Res, GeofenceZone>;
  @useResult
  $Res call(
      {String id,
      String placeId,
      double lat,
      double lng,
      double radiusMeters,
      bool isActive});
}

/// @nodoc
class _$GeofenceZoneCopyWithImpl<$Res, $Val extends GeofenceZone>
    implements $GeofenceZoneCopyWith<$Res> {
  _$GeofenceZoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? placeId = null,
    Object? lat = null,
    Object? lng = null,
    Object? radiusMeters = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeofenceZoneImplCopyWith<$Res>
    implements $GeofenceZoneCopyWith<$Res> {
  factory _$$GeofenceZoneImplCopyWith(
          _$GeofenceZoneImpl value, $Res Function(_$GeofenceZoneImpl) then) =
      __$$GeofenceZoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String placeId,
      double lat,
      double lng,
      double radiusMeters,
      bool isActive});
}

/// @nodoc
class __$$GeofenceZoneImplCopyWithImpl<$Res>
    extends _$GeofenceZoneCopyWithImpl<$Res, _$GeofenceZoneImpl>
    implements _$$GeofenceZoneImplCopyWith<$Res> {
  __$$GeofenceZoneImplCopyWithImpl(
      _$GeofenceZoneImpl _value, $Res Function(_$GeofenceZoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? placeId = null,
    Object? lat = null,
    Object? lng = null,
    Object? radiusMeters = null,
    Object? isActive = null,
  }) {
    return _then(_$GeofenceZoneImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeofenceZoneImpl implements _GeofenceZone {
  const _$GeofenceZoneImpl(
      {required this.id,
      required this.placeId,
      required this.lat,
      required this.lng,
      this.radiusMeters = 100.0,
      this.isActive = true});

  factory _$GeofenceZoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeofenceZoneImplFromJson(json);

  @override
  final String id;
  @override
  final String placeId;
  @override
  final double lat;
  @override
  final double lng;
  @override
  @JsonKey()
  final double radiusMeters;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'GeofenceZone(id: $id, placeId: $placeId, lat: $lat, lng: $lng, radiusMeters: $radiusMeters, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeofenceZoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, placeId, lat, lng, radiusMeters, isActive);

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeofenceZoneImplCopyWith<_$GeofenceZoneImpl> get copyWith =>
      __$$GeofenceZoneImplCopyWithImpl<_$GeofenceZoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeofenceZoneImplToJson(
      this,
    );
  }
}

abstract class _GeofenceZone implements GeofenceZone {
  const factory _GeofenceZone(
      {required final String id,
      required final String placeId,
      required final double lat,
      required final double lng,
      final double radiusMeters,
      final bool isActive}) = _$GeofenceZoneImpl;

  factory _GeofenceZone.fromJson(Map<String, dynamic> json) =
      _$GeofenceZoneImpl.fromJson;

  @override
  String get id;
  @override
  String get placeId;
  @override
  double get lat;
  @override
  double get lng;
  @override
  double get radiusMeters;
  @override
  bool get isActive;

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeofenceZoneImplCopyWith<_$GeofenceZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
