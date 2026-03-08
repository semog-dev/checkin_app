import 'package:domain/src/repositories/auth_repository.dart';
import 'package:domain/src/use_cases/watch_auth_state.dart';
import 'package:test/test.dart';

import '../helpers/mock_auth_repository.dart';

void main() {
  late MockAuthRepository repository;
  late WatchAuthState useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = WatchAuthState(repository);
  });

  group('WatchAuthState', () {
    test('emite uid quando usuário está autenticado', () async {
      repository.uidToEmit = 'user-123';

      final uid = await useCase().first;

      expect(uid, 'user-123');
    });

    test('emite null quando usuário não está autenticado', () async {
      repository.uidToEmit = null;

      final uid = await useCase().first;

      expect(uid, isNull);
    });

    test('propaga erro do repositório no stream', () {
      repository.errorToThrow = Exception('erro de autenticação');

      expect(useCase(), emitsError(isException));
    });

    test('retorna Stream<String?>', () {
      expect(useCase(), isA<Stream<String?>>());
    });

    test('emite sequência autenticado → deslogado', () async {
      final streamRepo = _MultiEmitMockAuthRepository(
        Stream.fromIterable(['user-1', null]),
      );
      final multiUseCase = WatchAuthState(streamRepo);

      final results = await multiUseCase().take(2).toList();

      expect(results[0], 'user-1');
      expect(results[1], isNull);
    });
  });
}

class _MultiEmitMockAuthRepository implements AuthRepository {
  _MultiEmitMockAuthRepository(this._stream);

  final Stream<String?> _stream;

  @override
  Stream<String?> watchAuthStateChanges() => _stream;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async =>
      'mock-uid';

  @override
  Future<void> signOut() async {}
}
