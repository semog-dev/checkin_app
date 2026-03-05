import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum UserStatus { online, offline, busy, away }

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required String displayName,
    required String email,
    String? photoUrl,
    @Default(UserStatus.offline) UserStatus status,
    @Default([]) List<String> groupIds,
    DateTime? lastSeenAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
