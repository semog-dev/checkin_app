import 'package:domain/src/entities/group.dart';
import 'package:domain/src/use_cases/watch_group_status.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';
import '../helpers/mock_repositories.dart';

void main() {
  late MockGroupRepository repository;
  late WatchGroupStatus useCase;

  setUp(() {
    repository = MockGroupRepository();
    useCase = WatchGroupStatus(repository);
  });

  group('WatchGroupStatus', () {
    test('delega userId ao repositório', () {
      useCase('user-1');

      expect(repository.lastWatchedUserId, 'user-1');
    });

    test('retorna stream de grupos do repositório', () async {
      final groups = [
        makeGroup(id: 'g1', name: 'Família'),
        makeGroup(id: 'g2', name: 'Trabalho'),
      ];
      repository.groupsToEmit = groups;

      final result = await useCase('user-1').first;

      expect(result, equals(groups));
    });

    test('retorna stream vazia quando usuário não tem grupos', () async {
      repository.groupsToEmit = [];

      final result = await useCase('user-1').first;

      expect(result, isEmpty);
    });

    test('retorna stream com múltiplos grupos', () async {
      repository.groupsToEmit = List.generate(
        5,
        (i) => makeGroup(id: 'g$i', name: 'Grupo $i', inviteCode: 'CODE$i'),
      );

      final result = await useCase('user-1').first;

      expect(result, hasLength(5));
    });

    test('propaga erro do repositório no stream', () {
      repository.errorToThrow = Exception('timeout');

      expect(useCase('user-1'), emitsError(isException));
    });

    test('usa o userId fornecido (não hardcoded)', () {
      useCase('outro-user');

      expect(repository.lastWatchedUserId, 'outro-user');
    });

    test('retorna Stream<List<Group>>', () {
      expect(useCase('user-1'), isA<Stream<List<Group>>>());
    });

    test('mantém ordem dos grupos retornados pelo repositório', () async {
      final groups = [
        makeGroup(id: 'g3', name: 'C', inviteCode: 'C1'),
        makeGroup(id: 'g1', name: 'A', inviteCode: 'A1'),
        makeGroup(id: 'g2', name: 'B', inviteCode: 'B1'),
      ];
      repository.groupsToEmit = groups;

      final result = await useCase('user-1').first;

      expect(result.map((g) => g.id).toList(), ['g3', 'g1', 'g2']);
    });
  });
}
