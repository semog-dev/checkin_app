import 'package:checkin_app/features/group/presentation/providers/group_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GroupsPage extends ConsumerWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Grupos')),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'join',
            icon: const Icon(Icons.group_add),
            label: const Text('Entrar'),
            onPressed: () => context.push(AppRoutes.joinGroup),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'create',
            icon: const Icon(Icons.add),
            label: const Text('Criar'),
            onPressed: () => context.push(AppRoutes.createGroup),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (msg) => Center(child: Text(msg)),
        loaded: (groups) {
          if (groups.isEmpty) {
            return const Center(
              child: Text('Nenhum grupo ainda.\nCrie ou entre em um grupo.'),
            );
          }
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, i) {
              final group = groups[i];
              return ListTile(
                leading: const Icon(Icons.group),
                title: Text(group.name),
                subtitle: Text('${group.memberIds.length} membros'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(
                  AppRoutes.groupDetail.replaceFirst(':id', group.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
