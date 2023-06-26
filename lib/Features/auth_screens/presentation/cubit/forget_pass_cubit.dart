import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository.dart';

part 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  ForgetPassCubit({required this.authRepository})
      : super(ForgetPassState.initial());
  final AuthRepository authRepository;

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
      boxText: null,
    ));
  }

  void resetState() {
    emit(ForgetPassState.initial());
  }

  void sendForgotPassword() async {
    String res = '';
    emit(state.copyWith(isSending: true));
    await Future.delayed(const Duration(seconds: 1));
    res = await authRepository.forgotPassword(state.email);
    if (res == 'succes') {
      emit(state.copyWith(
          isSent: true,
          isSending: false,
          boxText: 'Check your email box for reset password'));
    } else {
      _authValidateFromFirebase(res);
    }
  }

  void _authValidateFromFirebase(String res) {
    switch (res) {
      case 'The provided email is already in use.':
        emit(state.copyWith(boxText: res, isSending: false, isSent: false));
        break;
      case 'Invalid email address.':
        emit(state.copyWith(boxText: res, isSending: false, isSent: false));
        break;
      case 'The operation is not allowed.':
        emit(state.copyWith(boxText: res, isSending: false, isSent: false));
        break;

      case 'The user has been disabled.' 'user-disabled':
        emit(state.copyWith(boxText: res, isSending: false, isSent: false));
        break;
      case 'The user was not found.':
        emit(state.copyWith(boxText: res, isSending: false, isSent: false));
        break;
      default:
        emit(state.copyWith(boxText: res, isSending: false, isSent: false));
        break;
    }
  }
}
