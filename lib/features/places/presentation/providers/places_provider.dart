import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Repository ────────────────────────────────────────────────────────────────

final placeRepositoryProvider = Provider<PlaceRepository>(
  (ref) => throw UnimplementedError('placeRepositoryProvider not overridden'),
);

// ── Places stream ─────────────────────────────────────────────────────────────

final placesProvider = StreamProvider<List<Place>>((ref) {
  final authState = ref.watch(authNotifierProvider);
  final uid = authState is AuthAuthenticated ? authState.uid : null;
  if (uid == null) return const Stream.empty();

  final repository = ref.watch(placeRepositoryProvider);
  return GetPlaces(repository)(uid);
});

// ── Notifier (create / delete) ────────────────────────────────────────────────

final placesNotifierProvider =
    NotifierProvider<PlacesNotifier, void>(PlacesNotifier.new);

class PlacesNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<void> create({
    required String name,
    required double lat,
    required double lng,
    String? description,
    PlaceCategory category = PlaceCategory.other,
  }) async {
    final authState = ref.read(authNotifierProvider);
    final uid = authState is AuthAuthenticated ? authState.uid : null;
    if (uid == null) return;

    final place = Place(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      ownerId: uid,
      lat: lat,
      lng: lng,
      description: description,
      category: category,
      createdAt: DateTime.now(),
    );

    await CreatePlace(ref.read(placeRepositoryProvider))(place);
  }

  Future<void> delete(String id) async {
    await ref.read(placeRepositoryProvider).deletePlace(id);
  }
}
