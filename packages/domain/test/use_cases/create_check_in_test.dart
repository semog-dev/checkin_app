import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/use_cases/create_check_in.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';
import '../helpers/mock_repositories.dart';

void main() {
  late MockCheckInRepository repository;
  late CreateCheckIn useCase;

  setUp(() {
    repository = MockCheckInRepository();
    useCase = CreateCheckIn(repository);
  });

  group('CreateCheckIn', () {
    test('delega o evento ao repositório', () async {
      final event = makeCheckInEvent();

      await useCase(event);

      expect(repository.lastRecordedEvent, equals(event));
    });

    test('passa evento do tipo enter corretamente', () async {
      final event = makeCheckInEvent(type: CheckInEventType.enter);

      await useCase(event);

      expect(repository.lastRecordedEvent?.type, CheckInEventType.enter);
    });

    test('passa evento do tipo exit corretamente', () async {
      final event = makeCheckInEvent(type: CheckInEventType.exit);

      await useCase(event);

      expect(repository.lastRecordedEvent?.type, CheckInEventType.exit);
    });

    test('preserva accuracyMeters no evento gravado', () async {
      final event = makeCheckInEvent(accuracyMeters: 7.5);

      await useCase(event);

      expect(repository.lastRecordedEvent?.accuracyMeters, 7.5);
    });

    test('preserva userId e placeId no evento gravado', () async {
      final event =
          makeCheckInEvent(userId: 'u-especial', placeId: 'p-especial');

      await useCase(event);

      expect(repository.lastRecordedEvent?.userId, 'u-especial');
      expect(repository.lastRecordedEvent?.placeId, 'p-especial');
    });

    test('propaga exceção do repositório', () {
      repository.errorToThrow = Exception('falha de rede');
      final event = makeCheckInEvent();

      expect(() => useCase(event), throwsException);
    });

    test('retorna Future<void> ao completar com sucesso', () async {
      final event = makeCheckInEvent();

      await expectLater(useCase(event), completes);
    });
  });
}
