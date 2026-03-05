import 'package:domain/src/entities/group.dart';
import 'package:domain/src/repositories/group_repository.dart';

class WatchGroupStatus {
  const WatchGroupStatus(this._repository);

  final GroupRepository _repository;

  Stream<List<Group>> call(String userId) =>
      _repository.watchGroupsForUser(userId);
}
