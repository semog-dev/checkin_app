import 'package:domain/src/repositories/auth_repository.dart';

class WatchAuthState {
  const WatchAuthState(this._repository);

  final AuthRepository _repository;

  Stream<String?> call() => _repository.watchAuthStateChanges();
}
