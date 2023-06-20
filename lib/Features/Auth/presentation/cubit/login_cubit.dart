import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rcp_new/Features/Auth/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository}) : super(LoginState.initial());
  final AuthRepository authRepository;

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
      emailError: null,
      errorText: null,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, passwordError: null, errorText: null));
  }

  void subbmitForm() async {
    String result = '';
    emit(state.copyWith(isSending: true));
    await Future.delayed(const Duration(seconds: 2));
    result = await authRepository.signInWithEmailAndPassword(
        state.email, state.password);
    if (result == 'succes') {
      emit(state.copyWith(isSucces: true, isSending: false, errorText: null));
      emit(LoginState.initial()); // reset state
    } else {
      _authValidateFromFirebase(result);
    }
  }

  void logOut() async {
    await authRepository.signOut();
    emit(state.copyWith(isSucces: false));
  }

  void signInGoogle() async {
    await authRepository.loginWithGoogle();
  }

  void signInFacebook() async {
    await authRepository.singInWithFacebook();
  }

  void _authValidateFromFirebase(String res) {
    switch (res) {
      case 'The provided email is already in use.':
        emit(
            state.copyWith(emailError: true, errorText: res, isSending: false));
        break;
      case 'Invalid email address.':
        emit(
            state.copyWith(emailError: true, errorText: res, isSending: false));
        break;
      case 'The operation is not allowed.':
        emit(state.copyWith(
            unimplementedError: true, errorText: res, isSending: false));
        break;
      case 'The password is too weak.':
        emit(state.copyWith(
            passwordError: true, errorText: res, isSending: false));
        break;
      case 'The user has been disabled.' 'user-disabled':
        emit(state.copyWith(
            unimplementedError: true, errorText: res, isSending: false));
        break;
      case 'The user was not found.':
        emit(
            state.copyWith(emailError: true, errorText: res, isSending: false));
        break;
      case 'Incorrect password.':
        emit(state.copyWith(
            passwordError: true, errorText: res, isSending: false));
        break;
      default:
        emit(state.copyWith(
            unimplementedError: true, errorText: res, isSending: false));
    }
  }
}
