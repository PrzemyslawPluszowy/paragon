import 'package:edge_detection/edge_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class CameraController {
  Future<bool> checkCameraPermission();
  Future<String?> takePicture(bool permisionCamera, String? filePath);
  Future<String?> genrateFilePath();
}

class CameraControllerImpl implements CameraController {
  final EdgeDetection edgeDetection;

  CameraControllerImpl({required this.edgeDetection});

  @override
  Future<String?> takePicture(bool permisionCamera, String? filePath) async {
    if (permisionCamera && filePath != null) {
      try {
        bool success = await EdgeDetection.detectEdge(
          filePath,
          canUseGallery: true,
          androidScanTitle: 'Scanning', // use custom localizations for android
          androidCropTitle: 'Crop',
          androidCropBlackWhiteTitle: 'Black White',
          androidCropReset: 'Reset',
        );
        if (success) {
          return filePath;
        } else {
          filePath = null;
        }
      } catch (e) {
        throw Exception(e);
      }
    }
    return filePath;
  }

  @override
  Future<bool> checkCameraPermission() async {
    bool isCameraGranted = false;
    try {
      isCameraGranted = await Permission.camera.request().isGranted;
      if (!isCameraGranted) {
        isCameraGranted =
            await Permission.camera.request() == PermissionStatus.granted;
      }

      if (!isCameraGranted) {
        isCameraGranted = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return isCameraGranted;
  }

  @override
  Future<String?> genrateFilePath() async {
    try {
      String imagePath = join((await getApplicationSupportDirectory()).path,
          "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
      return imagePath;
    } catch (e) {
      throw Exception(e);
    }
  }
}
