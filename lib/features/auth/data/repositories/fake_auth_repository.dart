import 'dart:async';

import 'package:domain/domain.dart';

/// Implementação fake usada em desenvolvimento antes do Firebase ser configurado.
/// Mantém estado local via StreamController — permite testar o fluxo completo
/// de login/logout sem Firebase.
class FakeAuthRepository implements AuthRepository {
  final _controller = StreamController<String?>.broadcast();
  String? _currentUid;

  @override
  Stream<String?> watchAuthStateChanges() async* {
    yield _currentUid;
    yield* _controller.stream;
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _currentUid = 'fake-uid-${email.split('@').first}';
    _controller.add(_currentUid);
  }

  @override
  Future<void> signOut() async {
    _currentUid = null;
    _controller.add(null);
  }
}
