import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  Stream<String?> watchAuthStateChanges() =>
      _auth.authStateChanges().map((user) => user?.uid);

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> signOut() => _auth.signOut();
}
