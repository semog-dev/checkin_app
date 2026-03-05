// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Group {
  String get id;
  String get name;
  String get adminId;
  List<String> get memberIds;
  List<String> get placeIds;
  String get inviteCode;
  DateTime get createdAt;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupCopyWith<Group> get copyWith =>
      _$GroupCopyWithImpl<Group>(this as Group, _$identity);

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Group &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            const DeepCollectionEquality().equals(other.memberIds, memberIds) &&
            const DeepCollectionEquality().equals(other.placeIds, placeIds) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      adminId,
      const DeepCollectionEquality().hash(memberIds),
      const DeepCollectionEquality().hash(placeIds),
      inviteCode,
      createdAt);

  @override
  String toString() {
    return 'Group(id: $id, name: $name, adminId: $adminId, memberIds: $memberIds, placeIds: $placeIds, inviteCode: $inviteCode, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) =
      _$GroupCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String adminId,
      List<String> memberIds,
      List<String> placeIds,
      String inviteCode,
      DateTime createdAt});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res> implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminId = null,
    Object? memberIds = null,
    Object? placeIds = null,
    Object? inviteCode = null,
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
      adminId: null == adminId
          ? _self.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _self.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      placeIds: null == placeIds
          ? _self.placeIds
          : placeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inviteCode: null == inviteCode
          ? _self.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [Group].
extension GroupPatterns on Group {
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
    TResult Function(_Group value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Group() when $default != null:
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
    TResult Function(_Group value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Group():
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
    TResult? Function(_Group value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Group() when $default != null:
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
            String adminId,
            List<String> memberIds,
            List<String> placeIds,
            String inviteCode,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Group() when $default != null:
        return $default(_that.id, _that.name, _that.adminId, _that.memberIds,
            _that.placeIds, _that.inviteCode, _that.createdAt);
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
            String adminId,
            List<String> memberIds,
            List<String> placeIds,
            String inviteCode,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Group():
        return $default(_that.id, _that.name, _that.adminId, _that.memberIds,
            _that.placeIds, _that.inviteCode, _that.createdAt);
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
            String adminId,
            List<String> memberIds,
            List<String> placeIds,
            String inviteCode,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Group() when $default != null:
        return $default(_that.id, _that.name, _that.adminId, _that.memberIds,
            _that.placeIds, _that.inviteCode, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Group implements Group {
  const _Group(
      {required this.id,
      required this.name,
      required this.adminId,
      final List<String> memberIds = const [],
      final List<String> placeIds = const [],
      required this.inviteCode,
      required this.createdAt})
      : _memberIds = memberIds,
        _placeIds = placeIds;
  factory _Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String adminId;
  final List<String> _memberIds;
  @override
  @JsonKey()
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<String> _placeIds;
  @override
  @JsonKey()
  List<String> get placeIds {
    if (_placeIds is EqualUnmodifiableListView) return _placeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_placeIds);
  }

  @override
  final String inviteCode;
  @override
  final DateTime createdAt;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupCopyWith<_Group> get copyWith =>
      __$GroupCopyWithImpl<_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GroupToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Group &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            const DeepCollectionEquality().equals(other._placeIds, _placeIds) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      adminId,
      const DeepCollectionEquality().hash(_memberIds),
      const DeepCollectionEquality().hash(_placeIds),
      inviteCode,
      createdAt);

  @override
  String toString() {
    return 'Group(id: $id, name: $name, adminId: $adminId, memberIds: $memberIds, placeIds: $placeIds, inviteCode: $inviteCode, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) _then) =
      __$GroupCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String adminId,
      List<String> memberIds,
      List<String> placeIds,
      String inviteCode,
      DateTime createdAt});
}

/// @nodoc
class __$GroupCopyWithImpl<$Res> implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(this._self, this._then);

  final _Group _self;
  final $Res Function(_Group) _then;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminId = null,
    Object? memberIds = null,
    Object? placeIds = null,
    Object? inviteCode = null,
    Object? createdAt = null,
  }) {
    return _then(_Group(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adminId: null == adminId
          ? _self.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _self._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      placeIds: null == placeIds
          ? _self._placeIds
          : placeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inviteCode: null == inviteCode
          ? _self.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
