abstract interface class AuthRepository {
  Stream<String?> watchAuthStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
