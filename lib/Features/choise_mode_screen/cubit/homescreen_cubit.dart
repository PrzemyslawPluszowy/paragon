import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcp_new/Features/AddBill/cubit/addbill_cubit.dart';
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
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future initOcr() async {
    final textFromImage =
        await ocrController.convertingImegetoText(state.imagePath!);
    final categoryList = ocrController.getCategoryList();
    final listPrice = ocrController.getListPrice(textFromImage);
    final date = ocrController.getDateFromRecipe(textFromImage);
    final companyName = ocrController.getCompanyName(textFromImage);
    final listItems = ocrController.getListItem(textFromImage);
    AddbillState(
        title: '',
        categoryList: categoryList,
        isLoading: false,
        listItems: listItems,
        listPrice: listPrice,
        date: date,
        imagePath: state.imagePath,
        companyName: companyName);
    emit(AddRecipeLoaded(
        categoryList: categoryList,
        companyName: companyName,
        date: date,
        listItems: listItems,
        listPrice: listPrice,
        imagePath: state.imagePath,
        isLoading: false));
  }
}
