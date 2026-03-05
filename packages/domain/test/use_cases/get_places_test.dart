import 'package:domain/src/entities/place.dart';
import 'package:domain/src/use_cases/get_places.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';
import '../helpers/mock_repositories.dart';

void main() {
  late MockPlaceRepository repository;
  late GetPlaces useCase;

  setUp(() {
    repository = MockPlaceRepository();
    useCase = GetPlaces(repository);
  });

  group('GetPlaces', () {
    test('delega userId ao repositório', () {
      useCase('user-1');

      expect(repository.lastWatchedUserId, 'user-1');
    });

    test('retorna stream do repositório', () async {
      final places = [makePlace(id: 'p1'), makePlace(id: 'p2')];
      repository.placesToEmit = places;

      final result = await useCase('user-1').first;

      expect(result, equals(places));
    });

    test('retorna stream vazia quando não há locais', () async {
      repository.placesToEmit = [];

      final result = await useCase('user-1').first;

      expect(result, isEmpty);
    });

    test('retorna stream com um único local', () async {
      repository.placesToEmit = [makePlace()];

      final result = await useCase('user-1').first;

      expect(result, hasLength(1));
    });

    test('propaga erro do repositório no stream', () {
      repository.errorToThrow = Exception('erro de conexão');

      expect(useCase('user-1'), emitsError(isException));
    });

    test('usa o userId fornecido (não hardcoded)', () {
      useCase('outro-user');

      expect(repository.lastWatchedUserId, 'outro-user');
    });

    test('retorna Stream<List<Place>>', () {
      final stream = useCase('user-1');

      expect(stream, isA<Stream<List<Place>>>());
    });
  });
}
