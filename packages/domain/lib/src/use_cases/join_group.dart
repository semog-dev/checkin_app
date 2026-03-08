import 'package:domain/src/entities/group.dart';
import 'package:domain/src/repositories/group_repository.dart';

class JoinGroup {
  const JoinGroup(this._repository);

  final GroupRepository _repository;

  /// Procura o grupo pelo código de convite e adiciona [userId] como membro.
  /// Retorna o [Group] encontrado ou null se o código for inválido.
  Future<Group?> call({
    required String inviteCode,
    required String userId,
  }) async {
    final group = await _repository.findByInviteCode(inviteCode);
    if (group == null) return null;
    await _repository.addMember(group.id, userId);
    return group;
  }
}
