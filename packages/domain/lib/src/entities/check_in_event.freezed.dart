// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckInEvent _$CheckInEventFromJson(Map<String, dynamic> json) {
  return _CheckInEvent.fromJson(json);
}

/// @nodoc
mixin _$CheckInEvent {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get placeId => throw _privateConstructorUsedError;
  CheckInEventType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double? get accuracyMeters => throw _privateConstructorUsedError;

  /// Serializes this CheckInEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInEventCopyWith<CheckInEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInEventCopyWith<$Res> {
  factory $CheckInEventCopyWith(
          CheckInEvent value, $Res Function(CheckInEvent) then) =
      _$CheckInEventCopyWithImpl<$Res, CheckInEvent>;
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
class _$CheckInEventCopyWithImpl<$Res, $Val extends CheckInEvent>
    implements $CheckInEventCopyWith<$Res> {
  _$CheckInEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CheckInEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accuracyMeters: freezed == accuracyMeters
          ? _value.accuracyMeters
          : accuracyMeters // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckInEventImplCopyWith<$Res>
    implements $CheckInEventCopyWith<$Res> {
  factory _$$CheckInEventImplCopyWith(
          _$CheckInEventImpl value, $Res Function(_$CheckInEventImpl) then) =
      __$$CheckInEventImplCopyWithImpl<$Res>;
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
class __$$CheckInEventImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CheckInEventImpl>
    implements _$$CheckInEventImplCopyWith<$Res> {
  __$$CheckInEventImplCopyWithImpl(
      _$CheckInEventImpl _value, $Res Function(_$CheckInEventImpl) _then)
      : super(_value, _then);

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
    return _then(_$CheckInEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CheckInEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accuracyMeters: freezed == accuracyMeters
          ? _value.accuracyMeters
          : accuracyMeters // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckInEventImpl implements _CheckInEvent {
  const _$CheckInEventImpl(
      {required this.id,
      required this.userId,
      required this.placeId,
      required this.type,
      required this.timestamp,
      this.accuracyMeters});

  factory _$CheckInEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckInEventImplFromJson(json);

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

  @override
  String toString() {
    return 'CheckInEvent(id: $id, userId: $userId, placeId: $placeId, type: $type, timestamp: $timestamp, accuracyMeters: $accuracyMeters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInEventImpl &&
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

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInEventImplCopyWith<_$CheckInEventImpl> get copyWith =>
      __$$CheckInEventImplCopyWithImpl<_$CheckInEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckInEventImplToJson(
      this,
    );
  }
}

abstract class _CheckInEvent implements CheckInEvent {
  const factory _CheckInEvent(
      {required final String id,
      required final String userId,
      required final String placeId,
      required final CheckInEventType type,
      required final DateTime timestamp,
      final double? accuracyMeters}) = _$CheckInEventImpl;

  factory _CheckInEvent.fromJson(Map<String, dynamic> json) =
      _$CheckInEventImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get placeId;
  @override
  CheckInEventType get type;
  @override
  DateTime get timestamp;
  @override
  double? get accuracyMeters;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInEventImplCopyWith<_$CheckInEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
