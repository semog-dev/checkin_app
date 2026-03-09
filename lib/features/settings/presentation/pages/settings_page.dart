import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/geofencing/presentation/providers/geofencing_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentUserProfileProvider);
    final geofencingState = ref.watch(geofencingNotifierProvider);

    final isMonitoring = geofencingState is GeofencingMonitoring;

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          profileAsync.when(
            loading: () =>
                const _ProfileHeader(name: '...', email: '', initials: '?'),
            error: (_, __) =>
                const _ProfileHeader(name: 'Usuário', email: '', initials: '?'),
            data: (profile) => _ProfileHeader(
              name: profile?.displayName ?? 'Usuário',
              email: profile?.email ?? '',
              initials: _initials(profile?.displayName),
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Geofencing'),
          SwitchListTile(
            secondary: const Icon(Icons.radar),
            title: const Text('Monitoramento de localização'),
            subtitle: Text(
              isMonitoring ? 'Ativo — detectando check-ins' : 'Inativo',
            ),
            value: isMonitoring,
            onChanged: (enabled) {
              if (enabled) {
                ref
                    .read(geofencingNotifierProvider.notifier)
                    .startMonitoring();
              } else {
                ref.read(geofencingNotifierProvider.notifier).stopMonitoring();
              }
            },
          ),
          if (geofencingState is GeofencingNoPermission)
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.orange),
              title: const Text('Permissão negada'),
              subtitle: const Text(
                'Abra as configurações do sistema para conceder acesso',
              ),
              trailing: TextButton(
                onPressed: () => Geolocator.openAppSettings(),
                child: const Text('Abrir'),
              ),
            ),
          const Divider(),
          _SectionHeader(title: 'Conta'),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await ref.read(authNotifierProvider.notifier).signOut();
              if (context.mounted) context.go(AppRoutes.login);
            },
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
  });

  final String name;
  final String email;
  final String initials;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
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
          const SizedBox(width: 16),
          Column(
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
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
