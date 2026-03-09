import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── PlacesState ───────────────────────────────────────────────────────────────

sealed class PlacesState {
  const PlacesState();

  const factory PlacesState.loading() = PlacesLoading;
  const factory PlacesState.loaded({required List<Place> places}) = PlacesLoaded;
  const factory PlacesState.error({required String message}) = PlacesError;

  T when<T>({
    required T Function() loading,
    required T Function(List<Place> places) loaded,
    required T Function(String message) error,
  }) =>
      switch (this) {
        PlacesLoading() => loading(),
        PlacesLoaded(:final places) => loaded(places),
        PlacesError(:final message) => error(message),
      };
}

final class PlacesLoading extends PlacesState {
  const PlacesLoading();

  @override
  bool operator ==(Object other) => other is PlacesLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class PlacesLoaded extends PlacesState {
  const PlacesLoaded({required this.places});
  final List<Place> places;

  @override
  bool operator ==(Object other) =>
      other is PlacesLoaded && listEquals(other.places, places);

  @override
  int get hashCode => Object.hashAll(places);
}

final class PlacesError extends PlacesState {
  const PlacesError({required this.message});
  final String message;

  @override
  bool operator ==(Object other) =>
      other is PlacesError && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

// ── Repositories ──────────────────────────────────────────────────────────────

final placeRepositoryProvider = Provider<PlaceRepository>(
  (ref) => throw UnimplementedError('placeRepositoryProvider not overridden'),
);

final checkInRepositoryProvider = Provider<CheckInRepository>(
  (ref) => throw UnimplementedError('checkInRepositoryProvider not overridden'),
);

// ── Current user ID ───────────────────────────────────────────────────────────

final currentUserIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState is AuthAuthenticated ? authState.uid : null;
});

// ── Place events (histórico de check-ins de um local) ─────────────────────────

final placeEventsProvider =
    StreamProvider.family<List<CheckInEvent>, String>((ref, placeId) {
  return ref.watch(checkInRepositoryProvider).watchEventsForPlace(placeId);
});

// ── Notifier ──────────────────────────────────────────────────────────────────

final placesNotifierProvider =
    NotifierProvider<PlacesNotifier, PlacesState>(PlacesNotifier.new);

class PlacesNotifier extends Notifier<PlacesState> {
  @override
  PlacesState build() {
    final uid = ref.watch(currentUserIdProvider);
    if (uid == null) return const PlacesState.loading();

    final repo = ref.watch(placeRepositoryProvider);
    final sub = repo.watchPlaces(uid).listen(
      (places) => state = PlacesState.loaded(places: places),
      onError: (Object e) => state = PlacesState.error(message: e.toString()),
    );
    ref.onDispose(sub.cancel);

    return const PlacesState.loading();
  }

  Future<void> createPlace(Place place) async {
    try {
      await ref.read(placeRepositoryProvider).createPlace(place);
    } catch (e) {
      state = PlacesState.error(message: e.toString());
    }
  }

  Future<void> deletePlace(String id) async {
    try {
      await ref.read(placeRepositoryProvider).deletePlace(id);
    } catch (e) {
      state = PlacesState.error(message: e.toString());
    }
  }
}
