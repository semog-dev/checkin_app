import 'package:domain/src/entities/user_profile.dart';
import 'package:domain/src/repositories/user_repository.dart';
import 'package:domain/src/use_cases/get_user_profile.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';
import '../helpers/mock_repositories.dart';

void main() {
  late MockUserRepository repository;
  late GetUserProfile useCase;

  setUp(() {
    repository = MockUserRepository();
    useCase = GetUserProfile(repository);
  });

  group('GetUserProfile', () {
    test('retorna stream do usuário atual', () async {
      final profile = makeUserProfile();
      repository.profileToEmit = profile;

      final result = await useCase().first;

      expect(result, equals(profile));
    });

    test('retorna null quando não há usuário autenticado', () async {
      repository.profileToEmit = null;

      final result = await useCase().first;

      expect(result, isNull);
    });

    test('propaga erro do repositório no stream', () {
      repository.errorToThrow = Exception('erro de autenticação');

      expect(useCase(), emitsError(isException));
    });

    test('retorna Stream<UserProfile?>', () {
      expect(useCase(), isA<Stream<UserProfile?>>());
    });

    test('emite o perfil com status correto', () async {
      repository.profileToEmit = makeUserProfile(status: UserStatus.busy);

      final result = await useCase().first;

      expect(result?.status, UserStatus.busy);
    });

    test('emite múltiplos eventos consecutivos', () async {
      final profile1 = makeUserProfile(status: UserStatus.online);
      final profile2 = makeUserProfile(status: UserStatus.offline);

      final streamRepo = _StreamUserRepository(
        Stream.fromIterable([profile1, profile2]),
      );
      final multiUseCase = GetUserProfile(streamRepo);

      final results = await multiUseCase().take(2).toList();

      expect(results[0]?.status, UserStatus.online);
      expect(results[1]?.status, UserStatus.offline);
    });
  });
}

/// Mock simples que expõe um stream pré-configurado.
class _StreamUserRepository implements UserRepository {
  _StreamUserRepository(this._stream);

  final Stream<UserProfile?> _stream;

  @override
  Stream<UserProfile?> watchCurrentUser() => _stream;

  @override
  Future<UserProfile?> getUserById(String uid) async => null;

  @override
  Future<void> updateProfile(UserProfile profile) async {}

  @override
  Future<void> updateStatus(String uid, UserStatus status) async {}
}
