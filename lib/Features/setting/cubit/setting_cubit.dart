import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcp_new/Features/setting/setting_repo.dart';

import '../../auth_screens/repository.dart';
import '../../documents/cubit/documets_screen_cubit.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit({required this.settingRepo, required this.authRepository})
      : super(SettingState.initail());

  final AuthRepository authRepository;
  final SettingRepo settingRepo;

  logOut() async {
    try {
      emit(state.copyWith(isBusyl: true));
      await authRepository.signOut();
      emit(state.copyWith(isBusyl: false));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  deleteAllDatta(BuildContext context) async {
    try {
      emit(state.copyWith(isBusyl: true, status: 'Usuwanie danych...'));
      await settingRepo.deleteAlldata().then(
          (value) => context.read<DocumetsScreenCubit>().refreshDocument());
      emit(state.copyWith(isBusyl: false, status: 'Dane usunięte ( ͡° ͜ʖ ͡°)'));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  delteAccount(BuildContext context) async {
    try {
      await deleteAllDatta(context);
      emit(state.copyWith(isBusyl: true, status: 'Usuwanie konta...'));
      await authRepository.deleteAccount();
      await authRepository.signOut();
      emit(SettingState.initail());

      Fluttertoast.showToast(
          msg: 'Usunięto konto :(',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  changePass() async {
    try {
      emit(state.copyWith(isBusyl: true, status: 'Wysyłanie linku...'));
      await Future.delayed(Duration(seconds: 2));
      final userEmail = await authRepository.getCurrentUserEmail();
      if (userEmail != null) {
        await authRepository.forgotPassword(userEmail);
        emit(state.copyWith(
          isBusyl: false,
          status: 'Wysłano link na adres: $userEmail',
        ));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}
