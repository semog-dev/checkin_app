import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/geofencing/presentation/providers/geofencing_provider.dart';
import 'package:checkin_app/features/settings/presentation/providers/theme_provider.dart';
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
    final themeMode = ref.watch(themeModeProvider);

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
          // ── Aparência ───────────────────────────────────────────────────
          const _SectionHeader(title: 'Aparência'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(Icons.brightness_auto_outlined),
                  label: Text('Automático'),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode_outlined),
                  label: Text('Claro'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode_outlined),
                  label: Text('Escuro'),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (modes) =>
                  ref.read(themeModeProvider.notifier).setMode(modes.first),
            ),
          ),
          const Divider(),
          // ── Geofencing ──────────────────────────────────────────────────
          const _SectionHeader(title: 'Geofencing'),
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
              leading: Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
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
          // ── Conta ───────────────────────────────────────────────────────
          const _SectionHeader(title: 'Conta'),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Sair',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
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
      padding: const EdgeInsets.all(20),
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
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}
