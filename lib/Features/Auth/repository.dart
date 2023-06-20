import 'auth_data_source.dart';

abstract class AuthRepository {
  Future<String> createUserWithEmail(
      String email, String password, String name);

  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();
  Stream isUserLoggedIn();
  Future loginWithGoogle();
  Future singInWithFacebook();
  Future<String> forgotPassword(String email);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<String> createUserWithEmail(
      String email, String password, String name) {
    return authDataSource.createUserWithEmail(email, password, name);
  }

  @override
  Future<String> forgotPassword(String email) =>
      authDataSource.forgotPassword(email);

  @override
  Stream isUserLoggedIn() => authDataSource.isUserLoggedIn();

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) {
    return authDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() {
    return authDataSource.signOut();
  }

  @override
  Future loginWithGoogle() {
    return authDataSource.loginWithGoogle();
  }

  @override
  Future singInWithFacebook() {
    return authDataSource.singInWithFacebook();
  }
}
