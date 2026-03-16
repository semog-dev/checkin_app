import 'dart:async';
import 'dart:math';

import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Repository provider ───────────────────────────────────────────────────────

final groupRepositoryProvider = Provider<GroupRepository>(
  (ref) => throw UnimplementedError('groupRepositoryProvider not overridden'),
);

// userRepositoryProvider vive em auth_provider.dart

// ── GroupsState ───────────────────────────────────────────────────────────────

sealed class GroupsState {
  const GroupsState();

  const factory GroupsState.loading() = GroupsLoading;
  const factory GroupsState.loaded({required List<Group> groups}) = GroupsLoaded;
  const factory GroupsState.error({required String message}) = GroupsError;

  T when<T>({
    required T Function() loading,
    required T Function(List<Group> groups) loaded,
    required T Function(String message) error,
  }) =>
      switch (this) {
        GroupsLoading() => loading(),
        GroupsLoaded(:final groups) => loaded(groups),
        GroupsError(:final message) => error(message),
      };
}

final class GroupsLoading extends GroupsState {
  const GroupsLoading();
}

final class GroupsLoaded extends GroupsState {
  const GroupsLoaded({required this.groups});
  final List<Group> groups;

  @override
  bool operator ==(Object other) =>
      other is GroupsLoaded && listEquals(other.groups, groups);

  @override
  int get hashCode => Object.hashAll(groups);
}

final class GroupsError extends GroupsState {
  const GroupsError({required this.message});
  final String message;
}

// ── Groups notifier ───────────────────────────────────────────────────────────

final groupsNotifierProvider =
    NotifierProvider<GroupsNotifier, GroupsState>(GroupsNotifier.new);

class GroupsNotifier extends Notifier<GroupsState> {
  @override
  GroupsState build() {
    final uid = ref.watch(currentUserIdProvider);
    if (uid == null) return const GroupsState.loading();

    final repo = ref.watch(groupRepositoryProvider);
    final sub = repo.watchGroupsForUser(uid).listen(
      (groups) => state = GroupsState.loaded(groups: groups),
      onError: (Object e) => state = GroupsState.error(message: e.toString()),
    );
    ref.onDispose(sub.cancel);

    return const GroupsState.loading();
  }

  Future<Group?> createGroup(String name) async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return null;

    final group = Group(
      id: _generateId(),
      name: name,
      adminId: uid,
      memberIds: [uid],
      inviteCode: _generateInviteCode(),
      createdAt: DateTime.now(),
    );

    try {
      await ref.read(groupRepositoryProvider).createGroup(group);
      return group;
    } catch (e) {
      state = GroupsState.error(message: e.toString());
      return null;
    }
  }

  Future<Group?> joinGroup(String inviteCode) async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return null;

    try {
      return await JoinGroup(ref.read(groupRepositoryProvider)).call(
        inviteCode: inviteCode.trim().toUpperCase(),
        userId: uid,
      );
    } catch (e) {
      state = GroupsState.error(message: e.toString());
      return null;
    }
  }

  String _generateId() =>
      DateTime.now().millisecondsSinceEpoch.toRadixString(36) +
      _randomChars(4);

  String _generateInviteCode() => _randomChars(6).toUpperCase();

  String _randomChars(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rng = Random.secure();
    return List.generate(length, (_) => chars[rng.nextInt(chars.length)]).join();
  }
}

// ── Group members (real-time) ─────────────────────────────────────────────────

/// Retorna o stream de [UserProfile] de um membro específico.
final memberProfileProvider =
    StreamProvider.family<UserProfile?, String>((ref, uid) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.watchUserById(uid);
});

/// Retorna todos os perfis dos membros de um grupo, em tempo real.
final groupMembersProvider =
    Provider.family<List<AsyncValue<UserProfile?>>, List<String>>(
  (ref, memberIds) =>
      memberIds.map((uid) => ref.watch(memberProfileProvider(uid))).toList(),
);

// ── Member history ────────────────────────────────────────────────────────────

typedef MemberHistoryParams = ({String userId, int daysBack});

/// Retorna a lista de eventos de check-in de um membro com o nome do local.
/// Os eventos são ordenados do mais recente para o mais antigo.
final memberHistoryProvider = FutureProvider.autoDispose
    .family<List<(CheckInEvent, String?)>, MemberHistoryParams>(
  (ref, params) async {
    final checkInRepo = ref.watch(checkInRepositoryProvider);
    final placeRepo = ref.watch(placeRepositoryProvider);
    final since = DateTime.now().subtract(Duration(days: params.daysBack));

    final events = await checkInRepo.getEventsForUser(
      params.userId,
      since: since,
    );

    final placeIds = events.map((e) => e.placeId).toSet();
    final places = await Future.wait(
      placeIds.map((id) => placeRepo.getPlaceById(id)),
    );
    final placeMap = Map.fromIterables(
      placeIds,
      places.map((p) => p?.name),
    );

    final sorted = [...events]
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.map((e) => (e, placeMap[e.placeId])).toList();
  },
);
