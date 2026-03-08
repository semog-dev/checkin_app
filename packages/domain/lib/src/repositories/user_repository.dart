import 'package:domain/src/entities/user_profile.dart';

abstract interface class UserRepository {
  Stream<UserProfile?> watchCurrentUser();
  Stream<UserProfile?> watchUserById(String uid);
  Future<UserProfile?> getUserById(String uid);
  Future<void> updateProfile(UserProfile profile);
  Future<void> updateStatus(String uid, UserStatus status);
}
