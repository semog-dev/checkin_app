import 'package:domain/src/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  String? lastSignInEmail;
  String? lastSignInPassword;
  bool signOutCalled = false;
  Exception? errorToThrow;

  String? uidToEmit;

  @override
  Stream<String?> watchAuthStateChanges() {
    if (errorToThrow != null) return Stream.error(errorToThrow!);
    return Stream.value(uidToEmit);
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastSignInEmail = email;
    lastSignInPassword = password;
  }

  @override
  Future<void> signOut() async {
    if (errorToThrow != null) throw errorToThrow!;
    signOutCalled = true;
  }
}
