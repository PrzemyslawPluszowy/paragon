import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authRepository})
      : super(RegisterState.initial());

  final AuthRepository authRepository;

  void nameChanged(String value) {
    emit(state.copyWith(name: value, nameError: false));
  }

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
      emailError: false,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, passwordError: false));
  }

  void rePasswordChanged(String value) {
    emit(state.copyWith(rePassword: value, rePasswordError: false));
  }

  void subbmitForm() async {
    String result = '';
// check name form
    emit(state.copyWith(isSending: true));
    if (state.name.isEmpty || state.name.length < 4) {
      emit(state.copyWith(
          nameError: true, errorText: 'Name is required', isSending: false));
      return;
    }
// check password is equal
    if (state.password != state.rePassword) {
      emit(state.copyWith(
          rePasswordError: true,
          errorText: 'Password is not equal',
          isSending: false));
      return;
    }
// start creating account
    emit(state.copyWith(isSending: true));
    await Future.delayed(const Duration(seconds: 2));

    result = await authRepository.createUserWithEmail(
        state.email, state.password, state.name);
    if (result == 'succes') {
      emit(state.copyWith(isSucces: true, isSending: false));
      emit(RegisterState.initial()); // reset state
    } else {
      _authValidateFromFirebase(result);
    }
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
