import 'package:domain/src/entities/group.dart';
import 'package:domain/src/repositories/group_repository.dart';

class CreateGroup {
  const CreateGroup(this._repository);

  final GroupRepository _repository;

  Future<void> call(Group group) => _repository.createGroup(group);
}
