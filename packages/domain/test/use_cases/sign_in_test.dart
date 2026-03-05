import 'package:domain/src/use_cases/sign_in.dart';
import 'package:test/test.dart';

import '../helpers/mock_auth_repository.dart';

void main() {
  late MockAuthRepository repository;
  late SignIn useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = SignIn(repository);
  });

  group('SignIn', () {
    test('delega email e senha ao repositório', () async {
      await useCase(email: 'alice@example.com', password: 'senha123');

      expect(repository.lastSignInEmail, 'alice@example.com');
      expect(repository.lastSignInPassword, 'senha123');
    });

    test('completa sem exceção quando credenciais são válidas', () async {
      await expectLater(
        useCase(email: 'alice@example.com', password: 'senha123'),
        completes,
      );
    });

    test('propaga exceção de credenciais inválidas', () {
      repository.errorToThrow = Exception('credenciais inválidas');

      expect(
        () => useCase(email: 'wrong@example.com', password: 'errada'),
        throwsException,
      );
    });

    test('propaga exceção de rede', () {
      repository.errorToThrow = Exception('sem conexão');

      expect(
        () => useCase(email: 'alice@example.com', password: 'senha123'),
        throwsException,
      );
    });

    test('retorna Future<void>', () {
      final result = useCase(email: 'a@b.com', password: '123');
      expect(result, isA<Future<void>>());
    });
  });
}
