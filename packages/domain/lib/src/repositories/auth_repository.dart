abstract interface class AuthRepository {
  Stream<String?> watchAuthStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Cria uma nova conta e retorna o UID do usuário criado.
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signOut();
}
