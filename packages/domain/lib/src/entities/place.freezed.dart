// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Place {
  String get id;
  String get name;
  String get ownerId;
  double get lat;
  double get lng;
  String? get description;
  List<String> get memberIds;
  PlaceCategory get category;
  DateTime get createdAt;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlaceCopyWith<Place> get copyWith =>
      _$PlaceCopyWithImpl<Place>(this as Place, _$identity);

  /// Serializes this Place to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Place &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.memberIds, memberIds) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      ownerId,
      lat,
      lng,
      description,
      const DeepCollectionEquality().hash(memberIds),
      category,
      createdAt);

  @override
  String toString() {
    return 'Place(id: $id, name: $name, ownerId: $ownerId, lat: $lat, lng: $lng, description: $description, memberIds: $memberIds, category: $category, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PlaceCopyWith<$Res> {
  factory $PlaceCopyWith(Place value, $Res Function(Place) _then) =
      _$PlaceCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String ownerId,
      double lat,
      double lng,
      String? description,
      List<String> memberIds,
      PlaceCategory category,
      DateTime createdAt});
}

/// @nodoc
class _$PlaceCopyWithImpl<$Res> implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._self, this._then);

  final Place _self;
  final $Res Function(Place) _then;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerId = null,
    Object? lat = null,
    Object? lng = null,
    Object? description = freezed,
    Object? memberIds = null,
    Object? category = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      memberIds: null == memberIds
          ? _self.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as PlaceCategory,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [Place].
extension PlacePatterns on Place {
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
    TResult Function(_Place value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Place() when $default != null:
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
    TResult Function(_Place value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Place():
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
    TResult? Function(_Place value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Place() when $default != null:
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
    TResult Function(
            String id,
            String name,
            String ownerId,
            double lat,
            double lng,
            String? description,
            List<String> memberIds,
            PlaceCategory category,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Place() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.ownerId,
            _that.lat,
            _that.lng,
            _that.description,
            _that.memberIds,
            _that.category,
            _that.createdAt);
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
    TResult Function(
            String id,
            String name,
            String ownerId,
            double lat,
            double lng,
            String? description,
            List<String> memberIds,
            PlaceCategory category,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Place():
        return $default(
            _that.id,
            _that.name,
            _that.ownerId,
            _that.lat,
            _that.lng,
            _that.description,
            _that.memberIds,
            _that.category,
            _that.createdAt);
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
    TResult? Function(
            String id,
            String name,
            String ownerId,
            double lat,
            double lng,
            String? description,
            List<String> memberIds,
            PlaceCategory category,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Place() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.ownerId,
            _that.lat,
            _that.lng,
            _that.description,
            _that.memberIds,
            _that.category,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Place implements Place {
  const _Place(
      {required this.id,
      required this.name,
      required this.ownerId,
      required this.lat,
      required this.lng,
      this.description,
      final List<String> memberIds = const [],
      this.category = PlaceCategory.other,
      required this.createdAt})
      : _memberIds = memberIds;
  factory _Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String ownerId;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? description;
  final List<String> _memberIds;
  @override
  @JsonKey()
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  @override
  @JsonKey()
  final PlaceCategory category;
  @override
  final DateTime createdAt;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlaceCopyWith<_Place> get copyWith =>
      __$PlaceCopyWithImpl<_Place>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlaceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Place &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      ownerId,
      lat,
      lng,
      description,
      const DeepCollectionEquality().hash(_memberIds),
      category,
      createdAt);

  @override
  String toString() {
    return 'Place(id: $id, name: $name, ownerId: $ownerId, lat: $lat, lng: $lng, description: $description, memberIds: $memberIds, category: $category, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PlaceCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$PlaceCopyWith(_Place value, $Res Function(_Place) _then) =
      __$PlaceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String ownerId,
      double lat,
      double lng,
      String? description,
      List<String> memberIds,
      PlaceCategory category,
      DateTime createdAt});
}

/// @nodoc
class __$PlaceCopyWithImpl<$Res> implements _$PlaceCopyWith<$Res> {
  __$PlaceCopyWithImpl(this._self, this._then);

  final _Place _self;
  final $Res Function(_Place) _then;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerId = null,
    Object? lat = null,
    Object? lng = null,
    Object? description = freezed,
    Object? memberIds = null,
    Object? category = null,
    Object? createdAt = null,
  }) {
    return _then(_Place(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      memberIds: null == memberIds
          ? _self._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as PlaceCategory,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
