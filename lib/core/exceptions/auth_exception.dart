import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptionsHandler {
  String firebaseExceptions(dynamic firebaseException) {
    String res = '';

    if (firebaseException is FirebaseAuthException) {
      switch (firebaseException.code) {
        case 'email-already-in-use':
          res = 'The provided email is already in use.';
          break;
        case 'invalid-email':
          res = 'Invalid email address.';
          break;
        case 'operation-not-allowed':
          res = 'The operation is not allowed.';
          break;
        case 'weak-password':
          res = 'The password is too weak.';
          break;
        case 'user-disabled':
          res = 'The user has been disabled.';
          break;
        case 'user-not-found':
          res = 'The user was not found.';
          break;
        case 'wrong-password':
          res = 'Incorrect password.';
          break;
        default:
          res =
              'An authentication error occurred: ${firebaseException.message}';
      }
    } else {
      res = 'A general error occurred: $firebaseException';
    }

    return res;
  }
}
