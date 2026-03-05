import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_event.freezed.dart';
part 'check_in_event.g.dart';

enum CheckInEventType { enter, exit }

@freezed
class CheckInEvent with _$CheckInEvent {
  const factory CheckInEvent({
    required String id,
    required String userId,
    required String placeId,
    required CheckInEventType type,
    required DateTime timestamp,
    double? accuracyMeters,
  }) = _CheckInEvent;

  factory CheckInEvent.fromJson(Map<String, dynamic> json) =>
      _$CheckInEventFromJson(json);
}
