import 'package:checkin_app/features/geofencing/presentation/widgets/geofencing_status_bar.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class PlacesPage extends ConsumerWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(placesNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus locais')),
      body: Column(
        children: [
          const GeofencingStatusBar(),
          Expanded(
            child: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                key: const Key('places_error_message'),
                'Erro: $message',
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                key: const Key('retry_button'),
                onPressed: () => ref.invalidate(placesNotifierProvider),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
          loaded: (places) => places.isEmpty
                  ? const _EmptyState()
                  : _PlacesContent(places: places),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('add_place_fab'),
        onPressed: () => context.push(AppRoutes.addPlace),
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('empty_places_message'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Nenhum local cadastrado'),
          SizedBox(height: 8),
          Text(
            'Toque no botão + para adicionar',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _PlacesContent extends ConsumerWidget {
  const _PlacesContent({required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Map overview
        SizedBox(
          height: 240,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(places.first.lat, places.first.lng),
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.checkinApp',
              ),
              MarkerLayer(
                markers: places
                    .map(
                      (p) => Marker(
                        point: LatLng(p.lat, p.lng),
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 32,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        // List
        Expanded(
          child: ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return ListTile(
                key: const Key('place_card'),
                leading: const Icon(Icons.place),
                title: Text(place.name),
                subtitle: Text(place.category.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => ref
                      .read(placesNotifierProvider.notifier)
                      .deletePlace(place.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
