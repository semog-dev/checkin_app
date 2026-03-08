import 'dart:async';
import 'dart:io';

import 'package:checkin_app/features/geofencing/data/services/geofence_service.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// ── Repository provider ───────────────────────────────────────────────────────

final checkInRepositoryProvider = Provider<CheckInRepository>(
  (ref) => throw UnimplementedError('checkInRepositoryProvider not overridden'),
);

// ── Position stream provider (overridable in tests) ───────────────────────────

final positionStreamProvider = Provider<Stream<Position>>((ref) {
  if (Platform.isAndroid) {
    return Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        intervalDuration: const Duration(seconds: 10),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: 'CheckIn ativo',
          notificationText:
              'Monitorando sua localização em segundo plano.',
          enableWakeLock: true,
        ),
      ),
    );
  }

  if (Platform.isIOS || Platform.isMacOS) {
    return Geolocator.getPositionStream(
      locationSettings: AppleSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        activityType: ActivityType.other,
        pauseLocationUpdatesAutomatically: false,
        allowBackgroundLocationUpdates: true,
      ),
    );
  }

  return Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ),
  );
});

// ── GeofencingState ───────────────────────────────────────────────────────────

sealed class GeofencingState {
  const GeofencingState();

  const factory GeofencingState.idle() = GeofencingIdle;
  const factory GeofencingState.noPermission() = GeofencingNoPermission;
  const factory GeofencingState.monitoring({
    required Set<String> insidePlaceIds,
  }) = GeofencingMonitoring;
  const factory GeofencingState.error({required String message}) =
      GeofencingError;

  T when<T>({
    required T Function() idle,
    required T Function() noPermission,
    required T Function(Set<String> insidePlaceIds) monitoring,
    required T Function(String message) error,
  }) =>
      switch (this) {
        GeofencingIdle() => idle(),
        GeofencingNoPermission() => noPermission(),
        GeofencingMonitoring(:final insidePlaceIds) => monitoring(insidePlaceIds),
        GeofencingError(:final message) => error(message),
      };
}

final class GeofencingIdle extends GeofencingState {
  const GeofencingIdle();
}

final class GeofencingNoPermission extends GeofencingState {
  const GeofencingNoPermission();
}

final class GeofencingMonitoring extends GeofencingState {
  const GeofencingMonitoring({required this.insidePlaceIds});
  final Set<String> insidePlaceIds;
}

final class GeofencingError extends GeofencingState {
  const GeofencingError({required this.message});
  final String message;
}

// ── Notifier ──────────────────────────────────────────────────────────────────

final geofencingNotifierProvider =
    NotifierProvider<GeofencingNotifier, GeofencingState>(
  GeofencingNotifier.new,
);

class GeofencingNotifier extends Notifier<GeofencingState> {
  StreamSubscription<CheckInEvent>? _sub;

  @override
  GeofencingState build() {
    ref.onDispose(() => _sub?.cancel());
    return const GeofencingState.idle();
  }

  Future<void> startMonitoring() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;

    // 1. Verificar se o serviço de localização está habilitado
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = const GeofencingState.noPermission();
      return;
    }

    // 2. Verificar / solicitar permissão de localização
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      state = const GeofencingState.noPermission();
      return;
    }

    // 3. Solicitar permissão "sempre" para background location
    //    (whileInUse ainda funciona com foreground service no Android)
    if (permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      // Se o usuário não concedeu "sempre", continua com whileInUse
      // (o foreground service garante background no Android)
    }

    // 4. Build zones from current places
    final placesState = ref.read(placesNotifierProvider);
    final places = switch (placesState) {
      PlacesLoaded(:final places) => places,
      _ => <Place>[],
    };

    if (places.isEmpty) {
      state = const GeofencingState.monitoring(insidePlaceIds: {});
      return;
    }

    final zones = places
        .map(
          (p) => GeofenceZone(
            id: p.id,
            placeId: p.id,
            lat: p.lat,
            lng: p.lng,
          ),
        )
        .toList();

    // 5. Start monitoring
    state = const GeofencingState.monitoring(insidePlaceIds: {});

    await _sub?.cancel();
    _sub = GeofenceService()
        .watchCrossings(
          userId: uid,
          zones: zones,
          positionStream: ref.read(positionStreamProvider),
        )
        .listen(
          _onEvent,
          onError: (Object e) =>
              state = GeofencingState.error(message: e.toString()),
        );
  }

  Future<void> stopMonitoring() async {
    await _sub?.cancel();
    _sub = null;
    state = const GeofencingState.idle();
  }

  void _onEvent(CheckInEvent event) {
    final current = state;
    if (current is! GeofencingMonitoring) return;

    final updated = Set<String>.from(current.insidePlaceIds);
    if (event.type == CheckInEventType.enter) {
      updated.add(event.placeId);
    } else {
      updated.remove(event.placeId);
    }

    state = GeofencingMonitoring(insidePlaceIds: updated);
    ref.read(checkInRepositoryProvider).recordEvent(event);
  }
}
