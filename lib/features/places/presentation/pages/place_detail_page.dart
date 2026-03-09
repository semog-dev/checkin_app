import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class PlaceDetailPage extends ConsumerWidget {
  const PlaceDetailPage({super.key, required this.placeId});

  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesState = ref.watch(placesNotifierProvider);
    final place = switch (placesState) {
      PlacesLoaded(:final places) =>
        places.where((p) => p.id == placeId).firstOrNull,
      _ => null,
    };

    final eventsAsync = ref.watch(placeEventsProvider(placeId));

    return Scaffold(
      appBar: AppBar(title: Text(place?.name ?? 'Detalhe')),
      body: place == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _PlaceMap(place: place)),
                SliverToBoxAdapter(child: _PlaceInfo(place: place)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text(
                      'Histórico de check-ins',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                eventsAsync.when(
                  loading: () => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (e, _) => SliverFillRemaining(
                    child: Center(child: Text('Erro: $e')),
                  ),
                  data: (events) => events.isEmpty
                      ? const SliverFillRemaining(
                          child: Center(
                            child: Text('Nenhum check-in registrado'),
                          ),
                        )
                      : SliverList.builder(
                          itemCount: events.length,
                          itemBuilder: (context, i) =>
                              _EventTile(event: events[i]),
                        ),
                ),
              ],
            ),
    );
  }
}

class _PlaceMap extends StatelessWidget {
  const _PlaceMap({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final point = LatLng(place.lat, place.lng);
    return SizedBox(
      height: 200,
      child: FlutterMap(
        options: MapOptions(initialCenter: point, initialZoom: 15),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.checkinApp',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: point,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaceInfo extends StatelessWidget {
  const _PlaceInfo({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Chip(label: Text(place.category.name)),
              if (place.description != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    place.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${place.lat.toStringAsFixed(5)}, ${place.lng.toStringAsFixed(5)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final CheckInEvent event;

  @override
  Widget build(BuildContext context) {
    final isEnter = event.type == CheckInEventType.enter;
    final colorScheme = Theme.of(context).colorScheme;
    final dt = event.timestamp.toLocal();
    final dateStr =
        '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    final timeStr =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isEnter
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        child: Icon(
          isEnter ? Icons.login : Icons.logout,
          color: isEnter ? colorScheme.primary : colorScheme.outline,
          size: 20,
        ),
      ),
      title: Text(isEnter ? 'Entrada' : 'Saída'),
      subtitle: Text('$dateStr às $timeStr'),
      trailing: event.accuracyMeters != null
          ? Text(
              '±${event.accuracyMeters!.toStringAsFixed(0)}m',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                  ),
            )
          : null,
    );
  }
}
