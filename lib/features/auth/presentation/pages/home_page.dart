import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final uid = authState is AuthAuthenticated ? authState.uid : '—';

    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckIn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Olá, $uid'),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Meus locais'),
            subtitle: const Text('Gerencie seus check-in points'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.places),
          ),
        ],
      ),
    );
  }
}
