// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geofence_zone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeofenceZone {
  String get id;
  String get placeId;
  double get lat;
  double get lng;
  double get radiusMeters;
  bool get isActive;

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeofenceZoneCopyWith<GeofenceZone> get copyWith =>
      _$GeofenceZoneCopyWithImpl<GeofenceZone>(
          this as GeofenceZone, _$identity);

  /// Serializes this GeofenceZone to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeofenceZone &&
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

  @override
  String toString() {
    return 'GeofenceZone(id: $id, placeId: $placeId, lat: $lat, lng: $lng, radiusMeters: $radiusMeters, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class $GeofenceZoneCopyWith<$Res> {
  factory $GeofenceZoneCopyWith(
          GeofenceZone value, $Res Function(GeofenceZone) _then) =
      _$GeofenceZoneCopyWithImpl;
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
class _$GeofenceZoneCopyWithImpl<$Res> implements $GeofenceZoneCopyWith<$Res> {
  _$GeofenceZoneCopyWithImpl(this._self, this._then);

  final GeofenceZone _self;
  final $Res Function(GeofenceZone) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _self.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [GeofenceZone].
extension GeofenceZonePatterns on GeofenceZone {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GeofenceZone value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeofenceZone() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GeofenceZone value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceZone():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GeofenceZone value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceZone() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String placeId, double lat, double lng,
            double radiusMeters, bool isActive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeofenceZone() when $default != null:
        return $default(_that.id, _that.placeId, _that.lat, _that.lng,
            _that.radiusMeters, _that.isActive);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String placeId, double lat, double lng,
            double radiusMeters, bool isActive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceZone():
        return $default(_that.id, _that.placeId, _that.lat, _that.lng,
            _that.radiusMeters, _that.isActive);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String placeId, double lat, double lng,
            double radiusMeters, bool isActive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceZone() when $default != null:
        return $default(_that.id, _that.placeId, _that.lat, _that.lng,
            _that.radiusMeters, _that.isActive);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GeofenceZone implements GeofenceZone {
  const _GeofenceZone(
      {required this.id,
      required this.placeId,
      required this.lat,
      required this.lng,
      this.radiusMeters = 100.0,
      this.isActive = true});
  factory _GeofenceZone.fromJson(Map<String, dynamic> json) =>
      _$GeofenceZoneFromJson(json);

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

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeofenceZoneCopyWith<_GeofenceZone> get copyWith =>
      __$GeofenceZoneCopyWithImpl<_GeofenceZone>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeofenceZoneToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeofenceZone &&
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

  @override
  String toString() {
    return 'GeofenceZone(id: $id, placeId: $placeId, lat: $lat, lng: $lng, radiusMeters: $radiusMeters, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$GeofenceZoneCopyWith<$Res>
    implements $GeofenceZoneCopyWith<$Res> {
  factory _$GeofenceZoneCopyWith(
          _GeofenceZone value, $Res Function(_GeofenceZone) _then) =
      __$GeofenceZoneCopyWithImpl;
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
class __$GeofenceZoneCopyWithImpl<$Res>
    implements _$GeofenceZoneCopyWith<$Res> {
  __$GeofenceZoneCopyWithImpl(this._self, this._then);

  final _GeofenceZone _self;
  final $Res Function(_GeofenceZone) _then;

  /// Create a copy of GeofenceZone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? placeId = null,
    Object? lat = null,
    Object? lng = null,
    Object? radiusMeters = null,
    Object? isActive = null,
  }) {
    return _then(_GeofenceZone(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _self.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
