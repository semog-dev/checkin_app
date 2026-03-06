import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class AddPlacePage extends ConsumerStatefulWidget {
  const AddPlacePage({super.key});

  @override
  ConsumerState<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends ConsumerState<AddPlacePage> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  LatLng? _pickedLocation;
  PlaceCategory _category = PlaceCategory.other;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty || _pickedLocation == null) return;

    setState(() => _saving = true);
    await ref.read(placesNotifierProvider.notifier).create(
          name: name,
          lat: _pickedLocation!.latitude,
          lng: _pickedLocation!.longitude,
          description:
              _descController.text.trim().isEmpty ? null : _descController.text.trim(),
          category: _category,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo local')),
      body: Column(
        children: [
          // Map to pick location
          SizedBox(
            height: 280,
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: const LatLng(-23.55, -46.63),
                    initialZoom: 12,
                    onTap: (_, latlng) =>
                        setState(() => _pickedLocation = latlng),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.checkinApp',
                    ),
                    if (_pickedLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _pickedLocation!,
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
                if (_pickedLocation == null)
                  const Center(
                    child: IgnorePointer(
                      child: Text(
                        'Toque no mapa para escolher o local',
                        style: TextStyle(
                          backgroundColor: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    key: const Key('place_name_field'),
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome *'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<PlaceCategory>(
                    initialValue: _category,
                    decoration: const InputDecoration(labelText: 'Categoria'),
                    items: PlaceCategory.values
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _category = v!),
                  ),
                  const SizedBox(height: 24),
                  _saving
                      ? const Center(child: CircularProgressIndicator())
                      : FilledButton(
                          key: const Key('save_place_button'),
                          onPressed:
                              _pickedLocation != null ? _save : null,
                          child: const Text('Salvar'),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
