import 'package:checkin_app/features/geofencing/presentation/providers/geofencing_provider.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeofencingStatusBar extends ConsumerWidget {
  const GeofencingStatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(geofencingNotifierProvider);

    return state.when(
      idle: () => _IdleBar(
        onStart: () =>
            ref.read(geofencingNotifierProvider.notifier).startMonitoring(),
      ),
      noPermission: () => const _MessageBar(
        icon: Icons.location_off,
        color: Colors.orange,
        message: 'Permissão de localização negada',
      ),
      monitoring: (insidePlaceIds) => _MonitoringBar(
        insidePlaceIds: insidePlaceIds,
        onStop: () =>
            ref.read(geofencingNotifierProvider.notifier).stopMonitoring(),
        ref: ref,
      ),
      error: (message) => _MessageBar(
        icon: Icons.error_outline,
        color: Colors.red,
        message: message,
      ),
    );
  }
}

class _IdleBar extends StatelessWidget {
  const _IdleBar({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListTile(
        key: const Key('start_monitoring_tile'),
        leading: const Icon(Icons.radar),
        title: const Text('Monitoramento inativo'),
        subtitle: const Text('Toque para detectar check-ins automaticamente'),
        trailing: FilledButton.tonal(
          key: const Key('start_monitoring_button'),
          onPressed: onStart,
          child: const Text('Iniciar'),
        ),
      ),
    );
  }
}

class _MonitoringBar extends ConsumerWidget {
  const _MonitoringBar({
    required this.insidePlaceIds,
    required this.onStop,
    required this.ref,
  });

  final Set<String> insidePlaceIds;
  final VoidCallback onStop;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesState = ref.watch(placesNotifierProvider);
    final places = switch (placesState) {
      PlacesLoaded(:final places) => places,
      _ => const <Place>[],
    };

    final insideNames = places
        .where((p) => insidePlaceIds.contains(p.id))
        .map((p) => p.name)
        .join(', ');

    return Material(
      color: insidePlaceIds.isEmpty
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        key: const Key('monitoring_tile'),
        leading: Icon(
          Icons.my_location,
          color: insidePlaceIds.isEmpty
              ? null
              : Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          insidePlaceIds.isEmpty ? 'Monitorando...' : 'Dentro de: $insideNames',
        ),
        subtitle: const Text('Check-in automático ativo'),
        trailing: IconButton(
          key: const Key('stop_monitoring_button'),
          icon: const Icon(Icons.stop_circle_outlined),
          onPressed: onStop,
          tooltip: 'Parar monitoramento',
        ),
      ),
    );
  }
}

class _MessageBar extends StatelessWidget {
  const _MessageBar({
    required this.icon,
    required this.color,
    required this.message,
  });

  final IconData icon;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color.withValues(alpha: 0.1),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(message, style: TextStyle(color: color)),
      ),
    );
  }
}
