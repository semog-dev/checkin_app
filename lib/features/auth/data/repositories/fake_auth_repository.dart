import 'package:domain/domain.dart';

/// Implementação fake usada em desenvolvimento antes do Firebase ser configurado.
/// Emite null → usuário não autenticado → app exibe LoginPage.
class FakeAuthRepository implements AuthRepository {
  @override
  Stream<String?> watchAuthStateChanges() => Stream.value(null);

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}

  @override
  Future<void> signOut() async {}
}
