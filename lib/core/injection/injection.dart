import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:rcp_new/Features/Auth/presentation/cubit/register_cubit.dart';

import '../../Features/Auth/auth_data_source.dart';
import '../../Features/Auth/presentation/cubit/login_cubit.dart';
import '../../Features/Auth/repository.dart';

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
  //Auth Data Source
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(
      firebaseAuth: getIt.call(), firebaseFirestore: getIt.call()));

//Firebase
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
}
