import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/places/presentation/pages/add_place_page.dart';
import 'package:checkin_app/features/places/presentation/pages/places_page.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:domain/src/entities/place.dart';
import 'package:domain/src/repositories/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

Place _makePlace({String id = 'p1', String name = 'Casa'}) => Place(
      id: id,
      name: name,
      ownerId: 'user-1',
      lat: -23.5505,
      lng: -46.6333,
      createdAt: DateTime(2024, 6, 15),
    );

class _FakePlaceRepository implements PlaceRepository {
  final List<Place> places;
  _FakePlaceRepository({this.places = const []});

  @override
  Stream<List<Place>> watchPlaces(String userId) => Stream.value(places);

  @override
  Future<Place?> getPlaceById(String id) async => null;

  @override
  Future<void> createPlace(Place place) async {}

  @override
  Future<void> updatePlace(Place place) async {}

  @override
  Future<void> deletePlace(String id) async {}
}

class _AuthenticatedNotifier extends AuthNotifier {
  @override
  AuthState build() => const AuthState.authenticated(uid: 'user-1');
}

Widget _buildPage({List<Place> places = const [], Exception? error}) {
  return ProviderScope(
    overrides: [
      placeRepositoryProvider.overrideWithValue(
        error != null
            ? _ErrorPlaceRepository(error)
            : _FakePlaceRepository(places: places),
      ),
      authNotifierProvider.overrideWith(_AuthenticatedNotifier.new),
    ],
    child: const MaterialApp(home: PlacesPage()),
  );
}

Widget _buildRoutedPage({List<Place> places = const []}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const PlacesPage(),
      ),
      GoRoute(
        path: AppRoutes.addPlace,
        builder: (_, __) => const AddPlacePage(),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      placeRepositoryProvider.overrideWithValue(_FakePlaceRepository(places: places)),
      authNotifierProvider.overrideWith(_AuthenticatedNotifier.new),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('PlacesPage', () {
    group('estado de carregamento', () {
      testWidgets('exibe CircularProgressIndicator enquanto carrega', (
        tester,
      ) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              placeRepositoryProvider.overrideWithValue(
                _NeverEmitPlaceRepository(),
              ),
              authNotifierProvider.overrideWith(_AuthenticatedNotifier.new),
            ],
            child: const MaterialApp(home: PlacesPage()),
          ),
        );
        await tester.pump(); // apenas um frame, antes da stream emitir

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('estado carregado com locais', () {
      testWidgets('exibe lista de locais', (tester) async {
        final places = [
          _makePlace(id: 'p1', name: 'Casa'),
          _makePlace(id: 'p2', name: 'Trabalho'),
        ];
        await tester.pumpWidget(_buildPage(places: places));
        await tester.pumpAndSettle();

        expect(find.text('Casa'), findsOneWidget);
        expect(find.text('Trabalho'), findsOneWidget);
      });

      testWidgets('exibe card para cada local', (tester) async {
        final places = List.generate(
          3,
          (i) => _makePlace(id: 'p$i', name: 'Local $i'),
        );
        await tester.pumpWidget(_buildPage(places: places));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('place_card')), findsNWidgets(3));
      });

      testWidgets('exibe FAB para adicionar local', (tester) async {
        await tester.pumpWidget(_buildPage());
        await tester.pumpAndSettle();

        expect(find.byType(FloatingActionButton), findsOneWidget);
      });
    });

    group('estado vazio', () {
      testWidgets('exibe mensagem quando não há locais', (tester) async {
        await tester.pumpWidget(_buildPage(places: []));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('empty_places_message')), findsOneWidget);
      });
    });

    group('estado de erro', () {
      testWidgets('exibe mensagem de erro', (tester) async {
        await tester.pumpWidget(
          _buildPage(error: Exception('sem conexão')),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('places_error_message')), findsOneWidget);
      });

      testWidgets('exibe botão de tentar novamente', (tester) async {
        await tester.pumpWidget(
          _buildPage(error: Exception('sem conexão')),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('retry_button')), findsOneWidget);
      });
    });

    group('navegação', () {
      testWidgets('toca no FAB navega para AddPlacePage', (tester) async {
        await tester.pumpWidget(_buildRoutedPage());
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('add_place_page')), findsOneWidget);
      });
    });
  });
}

class _NeverEmitPlaceRepository implements PlaceRepository {
  @override
  Stream<List<Place>> watchPlaces(String userId) =>
      const Stream.empty(); // nunca emite

  @override
  Future<Place?> getPlaceById(String id) async => null;

  @override
  Future<void> createPlace(Place place) async {}

  @override
  Future<void> updatePlace(Place place) async {}

  @override
  Future<void> deletePlace(String id) async {}
}

class _ErrorPlaceRepository implements PlaceRepository {
  _ErrorPlaceRepository(this.error);
  final Exception error;

  @override
  Stream<List<Place>> watchPlaces(String userId) => Stream.error(error);

  @override
  Future<Place?> getPlaceById(String id) async => null;

  @override
  Future<void> createPlace(Place place) async {}

  @override
  Future<void> updatePlace(Place place) async {}

  @override
  Future<void> deletePlace(String id) async {}
}
