import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import '../../Features/auth_screens/auth_data_source.dart';
import '../../Features/auth_screens/presentation/cubit/login_cubit.dart';
import '../../Features/auth_screens/presentation/cubit/register_cubit.dart';
import '../../Features/auth_screens/repository.dart';
import '../../Features/bil_edit/data/bill_repo.dart';
import '../../Features/choise_mode_screen/camera_controller.dart';
import '../../Features/choise_mode_screen/ocr_controller.dart';
import '../../Features/documents/data/bill_get_repo.dart';
import '../../Features/setting/cubit/setting_cubit.dart';
import '../../Features/setting/data/pdf_controller.dart';
import '../../Features/setting/data/setting_repo.dart';

final getIt = GetIt.instance;

initDi() async {
//Auth Cubit
  getIt.registerFactory<LoginCubit>(
      () => LoginCubit(authRepository: getIt.call()));
  getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(authRepository: getIt.call()));
//Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: getIt.call()));
  //SettingCubit
  getIt.registerFactory<SettingCubit>(() => SettingCubit(
      authRepository: getIt.call(),
      settingRepo: getIt.call(),
      pdfController: getIt.call(),
      billGetRepo: getIt.call()));
  //Auth Data Source
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(
      firebaseAuth: getIt.call(), firebaseFirestore: getIt.call()));

//setting repo
  getIt.registerLazySingleton<SettingRepo>(() => SettingRepoImpl(
      firebaseFirestore: getIt.call(),
      firebaseAuth: getIt.call(),
      firebaseStorage: getIt.call()));

//camera controller repository
  getIt.registerLazySingleton<CameraController>(
      () => CameraControllerImpl(edgeDetection: getIt.call()));
  getIt.registerLazySingleton<OcrController>(() => OcrControllerImpl());

  // bill savwe repo
  getIt.registerLazySingleton<BillRepo>(() => BillRepoImpl(
      firebaseFirestore: getIt.call(), firebaseStorage: getIt.call()));
//pdf controller
  getIt.registerLazySingleton<PdfController>(() => PdfControllerImpl());
  // bii get repo
  getIt.registerLazySingleton<BillGetRepo>(() => BillGetRepoImpl(
      firebaseFirestore: getIt.call(), firebaseStorage: getIt.call()));
//Firebase
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<EdgeDetection>(() => EdgeDetection());
}
