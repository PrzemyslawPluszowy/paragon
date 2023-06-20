import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rcp_new/Features/Auth/user_model.dart';
import 'package:rcp_new/core/exceptions/auth_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcp_new/core/theme/theme.dart';

abstract class AuthDataSource {
  Future<String> createUserWithEmail(
      String email, String password, String name);

  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserInDB(String email, String password, String id);
  Future<void> signOut();
  Stream isUserLoggedIn();
  Future loginWithGoogle();
  Future singInWithFacebook();
  Future<String> forgotPassword(String email);
}

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  @override
  Future<String> createUserWithEmail(
      String email, String password, String name) async {
    String res = '';
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser != null) {
        await createUserInDB(email, name, firebaseAuth.currentUser!.uid);
        res = 'succes';
      }
    } on FirebaseAuthException catch (err) {
      res = AuthExceptionsHandler().firebaseExceptions(err);
    } catch (err) {
      res = AuthExceptionsHandler().firebaseExceptions(err);
    }
    return res;
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    String res = '';
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser != null) {
        res = 'succes';
      }
    } on FirebaseAuthException catch (err) {
      res = AuthExceptionsHandler().firebaseExceptions(err);
    } catch (err) {
      res = AuthExceptionsHandler().firebaseExceptions(err);
    }
    return res;
  }

  @override
  Future<void> createUserInDB(String email, String name, String id) async {
    final newUser = UserModel(id: id, name: name, email: email);
    try {
      firebaseFirestore.collection('users').add(newUser.toJson());
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Stream isUserLoggedIn() {
    return firebaseAuth.authStateChanges().handleError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
  }

  @override
  Future loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (userCredential.additionalUserInfo!.isNewUser) {
        if (user != null) {
          await createUserInDB(
              user.email!, user.displayName ?? user.email!, user.uid);
        } else {
          Fluttertoast.showToast(
              backgroundColor: FigmaColorsAuth.lightFiolet,
              textColor: FigmaColorsAuth.white,
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 4);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          backgroundColor: FigmaColorsAuth.lightFiolet,
          textColor: FigmaColorsAuth.white,
          msg: 'Something went wrong, try again or use another method',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 4);
    }
  }

//# TODO: fix facebook auth;
  @override
  Future singInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final user = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      if (user.additionalUserInfo!.isNewUser) {
        if (user.user != null) {
          await createUserInDB(user.user!.email!,
              user.user!.displayName ?? user.user!.email!, user.user!.uid);
        }
      }
    } catch (e) {}
  }

  @override
  Future<String> forgotPassword(String email) async {
    String res = '';
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      res = 'succes';
    } on FirebaseAuthException catch (err) {
      res = AuthExceptionsHandler().firebaseExceptions(err);
    } catch (err) {
      res = AuthExceptionsHandler().firebaseExceptions(err);
    }
    return res;
  }
}
