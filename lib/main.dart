import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rcp_new/Features/category_select/cubit/category_select_cubit.dart';
import 'package:rcp_new/Features/documents/cubit/documets_screen_cubit.dart';
import 'package:rcp_new/Features/setting/cubit/setting_cubit.dart';

import 'package:rcp_new/core/injection/injection.dart';
import 'package:rcp_new/firebase_options.dart';
import 'Features/auth_screens/presentation/cubit/auth_routing_cubit.dart';
import 'Features/auth_screens/presentation/cubit/forget_pass_cubit.dart';
import 'Features/auth_screens/presentation/cubit/login_cubit.dart';
import 'Features/auth_screens/presentation/cubit/register_cubit.dart';
import 'Features/auth_screens/presentation/pages/login_screen.dart';
import 'Features/bil_edit/cubit/bill_cubit.dart';
import 'Features/choise_mode_screen/cubit/homescreen_cubit.dart';
import 'Features/main_screen/cubit/mainscreen_cubit.dart';
import 'Features/main_screen/pages/main_screen.dart';
import 'core/routing/routing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthRoutingCubit(authRepository: getIt.call())
            ..initAuthGuardRouting(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(authRepository: getIt.call()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(authRepository: getIt.call()),
        ),
        BlocProvider(
          create: (context) => ForgetPassCubit(authRepository: getIt.call()),
        ),
        BlocProvider(create: (context) => MainscreenCubit()),
        BlocProvider(
            create: (context) => AddRecipeCubit(
                cameraController: getIt.call(),
                ocrController: getIt.call(),
                billGetRepo: getIt.call(),
                pdfController: getIt.call())),
        BlocProvider(create: (context) => BillCubit(billRepo: getIt.call())),
        BlocProvider(create: (context) => CategorySelectCubit()..sortList()),
        BlocProvider(
            create: (context) =>
                DocumetsScreenCubit(billGetRepo: getIt.call())..loadBills()),
        BlocProvider(
            create: (context) => SettingCubit(
                authRepository: getIt.call(),
                settingRepo: getIt.call(),
                billGetRepo: getIt.call(),
                pdfController: getIt.call())),
      ],
      child: MaterialApp.router(
        title: 'RecipeScaner',
        theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: RouteConfig.router,
      ),
    );
  }
}

class AuthRedirectWidget extends StatelessWidget {
  const AuthRedirectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthRoutingCubit, AuthRoutingState>(
      builder: (context, state) {
        if (state is AuthRoutingLogut) {
          return const LoginScreen();
        } else if (state is AuthRoutingLogin) {
          return const MainScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
