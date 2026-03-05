import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
abstract class Group with _$Group {
  const factory Group({
    required String id,
    required String name,
    required String adminId,
    @Default([]) List<String> memberIds,
    @Default([]) List<String> placeIds,
    required String inviteCode,
    required DateTime createdAt,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
