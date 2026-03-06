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
    final placesAsync = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus locais')),
      body: placesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (places) => places.isEmpty
            ? const _EmptyState()
            : _PlacesContent(places: places),
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
                leading: const Icon(Icons.place),
                title: Text(place.name),
                subtitle: Text(place.category.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => ref
                      .read(placesNotifierProvider.notifier)
                      .delete(place.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
