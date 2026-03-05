import 'package:domain/src/entities/user_profile.dart';
import 'package:domain/src/repositories/user_repository.dart';

class GetUserProfile {
  const GetUserProfile(this._repository);

  final UserRepository _repository;

  Stream<UserProfile?> call() => _repository.watchCurrentUser();
}
