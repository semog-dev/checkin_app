import 'package:checkin_app/features/group/presentation/providers/group_provider.dart';
import 'package:checkin_app/features/group/presentation/widgets/member_status_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupDetailPage extends ConsumerWidget {
  const GroupDetailPage({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsState = ref.watch(groupsNotifierProvider);

    final group = groupsState.when(
      loading: () => null,
      error: (_) => null,
      loaded: (groups) =>
          groups.where((g) => g.id == groupId).firstOrNull,
    );

    if (group == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Grupo')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartilhar convite',
            onPressed: () => _shareInvite(context, group.inviteCode),
          ),
        ],
      ),
      body: Column(
        children: [
          _InviteCard(inviteCode: group.inviteCode),
          const Divider(height: 1),
          Expanded(
            child: _MemberList(memberIds: group.memberIds),
          ),
        ],
      ),
    );
  }

  void _shareInvite(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Código copiado!')),
    );
  }
}

class _InviteCard extends StatelessWidget {
  const _InviteCard({required this.inviteCode});
  final String inviteCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.vpn_key, size: 18),
          const SizedBox(width: 8),
          Text('Convite: ', style: Theme.of(context).textTheme.bodySmall),
          Text(
            inviteCode,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.copy, size: 18),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: inviteCode));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Código copiado!')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MemberList extends ConsumerWidget {
  const _MemberList({required this.memberIds});
  final List<String> memberIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberValues = ref.watch(groupMembersProvider(memberIds));

    return ListView.builder(
      itemCount: memberIds.length,
      itemBuilder: (context, i) {
        final value = memberValues[i];
        return value.when(
          loading: () => const ListTile(
            leading: CircleAvatar(child: CircularProgressIndicator()),
            title: Text('Carregando...'),
          ),
          error: (e, _) => ListTile(title: Text('Erro: $e')),
          data: (profile) {
            if (profile == null) return const SizedBox.shrink();
            return MemberStatusTile(profile: profile);
          },
        );
      },
    );
  }
}
