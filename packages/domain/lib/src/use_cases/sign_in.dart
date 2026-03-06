import 'package:domain/src/repositories/auth_repository.dart';

class SignIn {
  const SignIn(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String email, required String password}) =>
      _repository.signInWithEmailAndPassword(email: email, password: password);
}
