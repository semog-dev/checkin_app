import 'package:domain/src/entities/group.dart';

abstract interface class GroupRepository {
  Stream<List<Group>> watchGroupsForUser(String userId);
  Future<Group?> getGroupById(String id);
  Future<void> createGroup(Group group);
  Future<void> addMember(String groupId, String userId);
  Future<void> removeMember(String groupId, String userId);
  Future<Group?> findByInviteCode(String inviteCode);
}
