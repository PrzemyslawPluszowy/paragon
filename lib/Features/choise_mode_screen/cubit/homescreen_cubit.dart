import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcp_new/core/data/model/company_model.dart';

import '../../../core/data/bill_model.dart';
import '../../documents/data/bill_get_repo.dart';
import '../../setting/data/pdf_controller.dart';
import '../../setting/models/pdf_model.dart';
import '../camera_controller.dart';
import '../ocr_controller.dart';

part 'homescreen_state.dart';

class AddRecipeCubit extends Cubit<AddRecipeState> {
  AddRecipeCubit(
      {required this.pdfController,
      required this.billGetRepo,
      required this.ocrController,
      required this.cameraController})
      : super(AddRecipeState.initail());

  final CameraController cameraController;
  final OcrController ocrController;
  final PdfController pdfController;
  final BillGetRepo billGetRepo;

  Future<void> initCamera() async {
    emit(AddRecipeState.initail());
    try {
      emit(state.copyWith(isLoading: true));

      bool permission = await cameraController.checkCameraPermission();
      String? filePatch = await cameraController.genrateFilePath();
      String? imagePath =
          await cameraController.takePicture(permission, filePatch);
      emit(state.copyWith(isLoading: false));
      if (imagePath != null) {
        emit(state.copyWith(isLoading: true, imagePath: imagePath));
        initOcr();
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      debugPrint(e.toString());

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIosWeb: 10,
      );
    }
  }

  Future initOcr() async {
    final textFromImage =
        await ocrController.convertingImegetoText(state.imagePath);
    final stringListHelper = ocrController.getStringHelper(textFromImage);

    final categoryList = ocrController.getCategoryList();
    final listPrice = ocrController.getListPrice(textFromImage);
    final date = ocrController.getDateFromRecipe(textFromImage);
    final companyName = ocrController.getCompanyName(textFromImage);
    final listItems = ocrController.getListItem(textFromImage);

    emit(state.copyWith(
        isLoading: false,
        listItems: listItems,
        listPrice: listPrice,
        categoryList: categoryList,
        date: Timestamp.fromDate(date ?? DateTime.now()),
        companyName: companyName,
        listHelper: stringListHelper));
  }

  createPdf() async {
    try {
      emit(state.copyWith(isBusyl: true, status: 'ładuje dane'));
      List<DocumentModel> dataFetched = await billGetRepo.getAlldocuments();
      emit(state.copyWith(
          isBusyl: true, status: 'Generuje pdf, to mi chwile zajmie...'));

      List<DocumetsToPdfModel> data =
          await pdfController.getDocumentsToPdf(dataFetched);
      final template = pdfController.pdfPageLayOut(data);
      emit(state.copyWith(isBusyl: true, status: 'Już prawie gotowe...'));

      final pdf = pdfController.createPdf(data, template);
      await pdfController.previewPDF(pdf);
      emit(
          state.copyWith(isBusyl: false, status: 'Zakończono generowanie pdf'));

      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(isBusyl: false, status: ''));
    } catch (e) {
      emit(state.copyWith(isBusyl: false, status: e.toString()));
    }
  }
}
