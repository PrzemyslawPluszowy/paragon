import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcp_new/Features/documents/data/bill_get_repo.dart';
import 'package:rcp_new/Features/setting/data/pdf_controller.dart';
import 'package:rcp_new/Features/setting/data/setting_repo.dart';
import 'package:rcp_new/core/data/bill_model.dart';

import '../../auth_screens/repository.dart';
import '../../documents/cubit/documets_screen_cubit.dart';
import '../models/pdfData.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(
      {required this.billGetRepo,
      required this.pdfController,
      required this.settingRepo,
      required this.authRepository})
      : super(SettingState.initail());

  final AuthRepository authRepository;
  final SettingRepo settingRepo;
  final PdfController pdfController;
  final BillGetRepo billGetRepo;

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
      await Future.delayed(const Duration(seconds: 500));
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

  createPdf() async {
    try {
      emit(state.copyWith(isBusyl: true, status: 'ładuje dane'));
      List<DocumentModel> dataFetched = await billGetRepo.getAlldocuments();
      emit(state.copyWith(
          isBusyl: true, status: 'generuje pdf, to mi chwile zajmie...'));

      List<DocumetsToPdfModel> data =
          await pdfController.getDocumentsToPdf(dataFetched);
      final template = pdfController.pdfPageLayOut(data);
      emit(state.copyWith(isBusyl: true, status: 'juz prawie  koniec'));

      final pdf = pdfController.createPdf(data, template);
      await pdfController.previewPDF(pdf);
      emit(
          state.copyWith(isBusyl: false, status: 'zakonczone generowanie pdf'));
    } catch (e) {
      emit(state.copyWith(isBusyl: false, status: e.toString()));
    }
  }
}
