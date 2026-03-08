// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {
  String get uid;
  String get displayName;
  String get email;
  String? get photoUrl;
  UserStatus get status;
  List<String> get groupIds;
  DateTime? get lastSeenAt;
  String? get currentPlaceId;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<UserProfile> get copyWith =>
      _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserProfile &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.groupIds, groupIds) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.currentPlaceId, currentPlaceId) ||
                other.currentPlaceId == currentPlaceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      displayName,
      email,
      photoUrl,
      status,
      const DeepCollectionEquality().hash(groupIds),
      lastSeenAt,
      currentPlaceId);

  @override
  String toString() {
    return 'UserProfile(uid: $uid, displayName: $displayName, email: $email, photoUrl: $photoUrl, status: $status, groupIds: $groupIds, lastSeenAt: $lastSeenAt, currentPlaceId: $currentPlaceId)';
  }
}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) _then) =
      _$UserProfileCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String displayName,
      String email,
      String? photoUrl,
      UserStatus status,
      List<String> groupIds,
      DateTime? lastSeenAt,
      String? currentPlaceId});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res> implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? displayName = null,
    Object? email = null,
    Object? photoUrl = freezed,
    Object? status = null,
    Object? groupIds = null,
    Object? lastSeenAt = freezed,
    Object? currentPlaceId = freezed,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      groupIds: null == groupIds
          ? _self.groupIds
          : groupIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastSeenAt: freezed == lastSeenAt
          ? _self.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentPlaceId: freezed == currentPlaceId
          ? _self.currentPlaceId
          : currentPlaceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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
    TResult Function(_UserProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
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
    TResult Function(_UserProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile():
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
    TResult? Function(_UserProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
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
            String uid,
            String displayName,
            String email,
            String? photoUrl,
            UserStatus status,
            List<String> groupIds,
            DateTime? lastSeenAt,
            String? currentPlaceId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(
            _that.uid,
            _that.displayName,
            _that.email,
            _that.photoUrl,
            _that.status,
            _that.groupIds,
            _that.lastSeenAt,
            _that.currentPlaceId);
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
            String uid,
            String displayName,
            String email,
            String? photoUrl,
            UserStatus status,
            List<String> groupIds,
            DateTime? lastSeenAt,
            String? currentPlaceId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile():
        return $default(
            _that.uid,
            _that.displayName,
            _that.email,
            _that.photoUrl,
            _that.status,
            _that.groupIds,
            _that.lastSeenAt,
            _that.currentPlaceId);
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
            String uid,
            String displayName,
            String email,
            String? photoUrl,
            UserStatus status,
            List<String> groupIds,
            DateTime? lastSeenAt,
            String? currentPlaceId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(
            _that.uid,
            _that.displayName,
            _that.email,
            _that.photoUrl,
            _that.status,
            _that.groupIds,
            _that.lastSeenAt,
            _that.currentPlaceId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserProfile implements UserProfile {
  const _UserProfile(
      {required this.uid,
      required this.displayName,
      required this.email,
      this.photoUrl,
      this.status = UserStatus.offline,
      final List<String> groupIds = const [],
      this.lastSeenAt,
      this.currentPlaceId})
      : _groupIds = groupIds;
  factory _UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  final String uid;
  @override
  final String displayName;
  @override
  final String email;
  @override
  final String? photoUrl;
  @override
  @JsonKey()
  final UserStatus status;
  final List<String> _groupIds;
  @override
  @JsonKey()
  List<String> get groupIds {
    if (_groupIds is EqualUnmodifiableListView) return _groupIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupIds);
  }

  @override
  final DateTime? lastSeenAt;
  @override
  final String? currentPlaceId;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserProfileCopyWith<_UserProfile> get copyWith =>
      __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserProfile &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._groupIds, _groupIds) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.currentPlaceId, currentPlaceId) ||
                other.currentPlaceId == currentPlaceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      displayName,
      email,
      photoUrl,
      status,
      const DeepCollectionEquality().hash(_groupIds),
      lastSeenAt,
      currentPlaceId);

  @override
  String toString() {
    return 'UserProfile(uid: $uid, displayName: $displayName, email: $email, photoUrl: $photoUrl, status: $status, groupIds: $groupIds, lastSeenAt: $lastSeenAt, currentPlaceId: $currentPlaceId)';
  }
}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(
          _UserProfile value, $Res Function(_UserProfile) _then) =
      __$UserProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      String displayName,
      String email,
      String? photoUrl,
      UserStatus status,
      List<String> groupIds,
      DateTime? lastSeenAt,
      String? currentPlaceId});
}

/// @nodoc
class __$UserProfileCopyWithImpl<$Res> implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? displayName = null,
    Object? email = null,
    Object? photoUrl = freezed,
    Object? status = null,
    Object? groupIds = null,
    Object? lastSeenAt = freezed,
    Object? currentPlaceId = freezed,
  }) {
    return _then(_UserProfile(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      groupIds: null == groupIds
          ? _self._groupIds
          : groupIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastSeenAt: freezed == lastSeenAt
          ? _self.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentPlaceId: freezed == currentPlaceId
          ? _self.currentPlaceId
          : currentPlaceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
