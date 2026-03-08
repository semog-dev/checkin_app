import 'package:domain/src/repositories/auth_repository.dart';

class SignUp {
  const SignUp(this._repository);

  final AuthRepository _repository;

  Future<String> call({
    required String email,
    required String password,
    required String displayName,
  }) =>
      _repository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
}
