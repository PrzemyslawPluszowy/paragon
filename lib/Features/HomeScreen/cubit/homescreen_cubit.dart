import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rcp_new/Features/HomeScreen/camera_controller.dart';

part 'homescreen_state.dart';

class HomescreenCubit extends Cubit<HomeScreenState> {
  HomescreenCubit({required this.cameraController})
      : super(HomeScreenState.initail());

  final CameraController cameraController;

  Future<void> initCamera() async {
    try {
      bool permission = await cameraController.checkCameraPermission();
      String? filePatch = await cameraController.genrateFilePath();
      String? imagePath =
          await cameraController.takePicture(permission, filePatch);
      if (imagePath != null) {
        emit(state.copyWith(filePath: imagePath, isCameraGranted: permission));
      }
    } catch (e) {}
  }
}
