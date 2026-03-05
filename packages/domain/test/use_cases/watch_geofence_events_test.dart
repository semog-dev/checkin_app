import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/use_cases/watch_geofence_events.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';
import '../helpers/mock_repositories.dart';

void main() {
  late MockCheckInRepository repository;
  late WatchGeofenceEvents useCase;

  setUp(() {
    repository = MockCheckInRepository();
    useCase = WatchGeofenceEvents(repository);
  });

  group('WatchGeofenceEvents', () {
    test('delega placeId ao repositório', () {
      useCase('place-1');

      expect(repository.lastWatchedPlaceId, 'place-1');
    });

    test('usa limit padrão de 50', () {
      useCase('place-1');

      expect(repository.lastWatchedLimit, 50);
    });

    test('passa limit personalizado ao repositório', () {
      useCase('place-1', limit: 10);

      expect(repository.lastWatchedLimit, 10);
    });

    test('retorna stream de eventos do repositório', () async {
      final events = [
        makeCheckInEvent(id: 'e1', type: CheckInEventType.enter),
        makeCheckInEvent(id: 'e2', type: CheckInEventType.exit),
      ];
      repository.eventsToEmit = events;

      final result = await useCase('place-1').first;

      expect(result, equals(events));
    });

    test('retorna stream vazia quando não há eventos', () async {
      repository.eventsToEmit = [];

      final result = await useCase('place-1').first;

      expect(result, isEmpty);
    });

    test('propaga erro do repositório no stream', () {
      repository.errorToThrow = Exception('sem conexão');

      expect(useCase('place-1'), emitsError(isException));
    });

    test('usa o placeId fornecido (não hardcoded)', () {
      useCase('outro-place');

      expect(repository.lastWatchedPlaceId, 'outro-place');
    });

    test('retorna Stream<List<CheckInEvent>>', () {
      expect(useCase('place-1'), isA<Stream<List<CheckInEvent>>>());
    });

    test('limit 1 é aceito', () {
      useCase('place-1', limit: 1);

      expect(repository.lastWatchedLimit, 1);
    });

    test('limit 100 é aceito', () {
      useCase('place-1', limit: 100);

      expect(repository.lastWatchedLimit, 100);
    });
  });
}
