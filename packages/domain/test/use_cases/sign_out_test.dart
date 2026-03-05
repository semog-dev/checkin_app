import 'package:domain/src/use_cases/sign_out.dart';
import 'package:test/test.dart';

import '../helpers/mock_auth_repository.dart';

void main() {
  late MockAuthRepository repository;
  late SignOut useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = SignOut(repository);
  });

  group('SignOut', () {
    test('delega signOut ao repositório', () async {
      await useCase();

      expect(repository.signOutCalled, isTrue);
    });

    test('completa sem exceção', () async {
      await expectLater(useCase(), completes);
    });

    test('propaga exceção do repositório', () {
      repository.errorToThrow = Exception('falha ao deslogar');

      expect(() => useCase(), throwsException);
    });

    test('retorna Future<void>', () {
      expect(useCase(), isA<Future<void>>());
    });
  });
}
