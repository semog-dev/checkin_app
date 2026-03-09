import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckIn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configurações',
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          profileAsync.when(
            loading: () => const _ProfileHeader(
              name: '...',
              email: '',
              initials: '?',
            ),
            error: (_, __) => const _ProfileHeader(
              name: 'Usuário',
              email: '',
              initials: '?',
            ),
            data: (profile) => _ProfileHeader(
              name: profile?.displayName ?? 'Usuário',
              email: profile?.email ?? '',
              initials: _initials(profile?.displayName),
              status: profile?.status,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Meus locais'),
            subtitle: const Text('Gerencie seus check-in points'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.places),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupos'),
            subtitle: const Text('Veja o status em tempo real'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.groups),
          ),
        ],
      ),
    );
  }

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.initials,
    this.status,
  });

  final String name;
  final String email;
  final String initials;
  final UserStatus? status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            if (status != null)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: _statusColor(status!),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (email.isNotEmpty)
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Color _statusColor(UserStatus status) => switch (status) {
        UserStatus.online => Colors.green,
        UserStatus.offline => Colors.grey,
        UserStatus.busy => Colors.orange,
        UserStatus.away => Colors.amber,
      };
}
