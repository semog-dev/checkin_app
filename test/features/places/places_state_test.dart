import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/src/entities/place.dart';
import 'package:flutter_test/flutter_test.dart';

Place _makePlace({String id = 'p1', String name = 'Casa'}) => Place(
  id: id,
  name: name,
  ownerId: 'user-1',
  lat: -23.5505,
  lng: -46.6333,
  createdAt: DateTime(2024, 6, 15),
);

void main() {
  group('PlacesState', () {
    group('factory constructors', () {
      test('loading() cria estado de carregamento', () {
        expect(const PlacesState.loading(), isA<PlacesLoading>());
      });

      test('loaded() carrega a lista de locais', () {
        final places = [_makePlace(), _makePlace(id: 'p2', name: 'Trabalho')];
        final state = PlacesState.loaded(places: places);

        expect(state, isA<PlacesLoaded>());
        expect((state as PlacesLoaded).places, equals(places));
      });

      test('loaded() com lista vazia é válido', () {
        const state = PlacesState.loaded(places: []);
        expect((state as PlacesLoaded).places, isEmpty);
      });

      test('error() carrega mensagem de erro', () {
        const state = PlacesState.error(message: 'sem conexão');
        expect(state, isA<PlacesError>());
        expect((state as PlacesError).message, 'sem conexão');
      });
    });

    group('igualdade', () {
      test('loading() == loading()', () {
        expect(const PlacesState.loading(), equals(const PlacesState.loading()));
      });

      test('loaded com mesmas listas são iguais', () {
        final places = [_makePlace()];
        expect(
          PlacesState.loaded(places: places),
          equals(PlacesState.loaded(places: places)),
        );
      });

      test('loaded com listas diferentes não são iguais', () {
        final a = PlacesState.loaded(places: [_makePlace(id: 'p1')]);
        final b = PlacesState.loaded(places: [_makePlace(id: 'p2')]);
        expect(a, isNot(equals(b)));
      });

      test('error com mesma mensagem são iguais', () {
        expect(
          const PlacesState.error(message: 'erro'),
          equals(const PlacesState.error(message: 'erro')),
        );
      });
    });

    group('pattern matching — when()', () {
      test('loading redireciona para loading branch', () {
        const state = PlacesState.loading();
        final result = state.when(
          loading: () => 'loading',
          loaded: (_) => 'loaded',
          error: (_) => 'error',
        );
        expect(result, 'loading');
      });

      test('loaded redireciona com lista de locais', () {
        final places = [_makePlace()];
        final state = PlacesState.loaded(places: places);
        final result = state.when(
          loading: () => <Place>[],
          loaded: (list) => list,
          error: (_) => <Place>[],
        );
        expect(result, equals(places));
      });

      test('error redireciona com mensagem', () {
        const state = PlacesState.error(message: 'timeout');
        final result = state.when(
          loading: () => '',
          loaded: (_) => '',
          error: (msg) => msg,
        );
        expect(result, 'timeout');
      });
    });
  });
}
