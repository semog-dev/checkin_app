// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckInEvent {
  String get id;
  String get userId;
  String get placeId;
  CheckInEventType get type;
  DateTime get timestamp;
  double? get accuracyMeters;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckInEventCopyWith<CheckInEvent> get copyWith =>
      _$CheckInEventCopyWithImpl<CheckInEvent>(
          this as CheckInEvent, _$identity);

  /// Serializes this CheckInEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckInEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.accuracyMeters, accuracyMeters) ||
                other.accuracyMeters == accuracyMeters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, placeId, type, timestamp, accuracyMeters);

  @override
  String toString() {
    return 'CheckInEvent(id: $id, userId: $userId, placeId: $placeId, type: $type, timestamp: $timestamp, accuracyMeters: $accuracyMeters)';
  }
}

/// @nodoc
abstract mixin class $CheckInEventCopyWith<$Res> {
  factory $CheckInEventCopyWith(
          CheckInEvent value, $Res Function(CheckInEvent) _then) =
      _$CheckInEventCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String placeId,
      CheckInEventType type,
      DateTime timestamp,
      double? accuracyMeters});
}

/// @nodoc
class _$CheckInEventCopyWithImpl<$Res> implements $CheckInEventCopyWith<$Res> {
  _$CheckInEventCopyWithImpl(this._self, this._then);

  final CheckInEvent _self;
  final $Res Function(CheckInEvent) _then;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? placeId = null,
    Object? type = null,
    Object? timestamp = null,
    Object? accuracyMeters = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CheckInEventType,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accuracyMeters: freezed == accuracyMeters
          ? _self.accuracyMeters
          : accuracyMeters // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CheckInEvent].
extension CheckInEventPatterns on CheckInEvent {
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
    TResult Function(_CheckInEvent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CheckInEvent() when $default != null:
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
    TResult Function(_CheckInEvent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CheckInEvent():
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
    TResult? Function(_CheckInEvent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CheckInEvent() when $default != null:
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
    TResult Function(String id, String userId, String placeId,
            CheckInEventType type, DateTime timestamp, double? accuracyMeters)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CheckInEvent() when $default != null:
        return $default(_that.id, _that.userId, _that.placeId, _that.type,
            _that.timestamp, _that.accuracyMeters);
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
    TResult Function(String id, String userId, String placeId,
            CheckInEventType type, DateTime timestamp, double? accuracyMeters)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CheckInEvent():
        return $default(_that.id, _that.userId, _that.placeId, _that.type,
            _that.timestamp, _that.accuracyMeters);
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
    TResult? Function(String id, String userId, String placeId,
            CheckInEventType type, DateTime timestamp, double? accuracyMeters)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CheckInEvent() when $default != null:
        return $default(_that.id, _that.userId, _that.placeId, _that.type,
            _that.timestamp, _that.accuracyMeters);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CheckInEvent implements CheckInEvent {
  const _CheckInEvent(
      {required this.id,
      required this.userId,
      required this.placeId,
      required this.type,
      required this.timestamp,
      this.accuracyMeters});
  factory _CheckInEvent.fromJson(Map<String, dynamic> json) =>
      _$CheckInEventFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String placeId;
  @override
  final CheckInEventType type;
  @override
  final DateTime timestamp;
  @override
  final double? accuracyMeters;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CheckInEventCopyWith<_CheckInEvent> get copyWith =>
      __$CheckInEventCopyWithImpl<_CheckInEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CheckInEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CheckInEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.accuracyMeters, accuracyMeters) ||
                other.accuracyMeters == accuracyMeters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, placeId, type, timestamp, accuracyMeters);

  @override
  String toString() {
    return 'CheckInEvent(id: $id, userId: $userId, placeId: $placeId, type: $type, timestamp: $timestamp, accuracyMeters: $accuracyMeters)';
  }
}

/// @nodoc
abstract mixin class _$CheckInEventCopyWith<$Res>
    implements $CheckInEventCopyWith<$Res> {
  factory _$CheckInEventCopyWith(
          _CheckInEvent value, $Res Function(_CheckInEvent) _then) =
      __$CheckInEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String placeId,
      CheckInEventType type,
      DateTime timestamp,
      double? accuracyMeters});
}

/// @nodoc
class __$CheckInEventCopyWithImpl<$Res>
    implements _$CheckInEventCopyWith<$Res> {
  __$CheckInEventCopyWithImpl(this._self, this._then);

  final _CheckInEvent _self;
  final $Res Function(_CheckInEvent) _then;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? placeId = null,
    Object? type = null,
    Object? timestamp = null,
    Object? accuracyMeters = freezed,
  }) {
    return _then(_CheckInEvent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CheckInEventType,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accuracyMeters: freezed == accuracyMeters
          ? _self.accuracyMeters
          : accuracyMeters // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
