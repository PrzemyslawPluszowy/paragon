import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcp_new/core/data/model/company_model.dart';

import '../camera_controller.dart';
import '../ocr_controller.dart';

part 'homescreen_state.dart';

class AddRecipeCubit extends Cubit<AddRecipeState> {
  AddRecipeCubit({required this.ocrController, required this.cameraController})
      : super(AddRecipeState.initail());

  final CameraController cameraController;
  final OcrController ocrController;

  Future<void> initCamera() async {
    emit(AddRecipeState.initail());
    try {
      emit(state.copyWith(isLoading: true));

      bool permission = await cameraController.checkCameraPermission();
      String? filePatch = await cameraController.genrateFilePath();
      String? imagePath =
          await cameraController.takePicture(permission, filePatch);
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
        companyName: companyName));
  }
}
