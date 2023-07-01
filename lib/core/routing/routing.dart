import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/Features/bil_screen/pages/full_image_screen.dart';
import 'package:rcp_new/core/data/bill_model.dart';

import 'package:rcp_new/core/routing/auth_guard.dart';
import 'package:rcp_new/main.dart';

import '../../Features/auth_screens/presentation/pages/forget_pass_screen.dart';
import '../../Features/auth_screens/presentation/pages/login_screen.dart';
import '../../Features/auth_screens/presentation/pages/register_screen.dart';
import '../../Features/auth_screens/repository.dart';
import '../../Features/bil_screen/pages/bill_screen.dart';
import '../../Features/category_select/pages/category_select_screen.dart';
import '../../Features/main_screen/pages/main_screen.dart';

class RouteConfig {
  final AuthRepository authRepository;
  RouteConfig({
    required this.authRepository,
  });

  static GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthRedirectWidget();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/forgot-pass',
      builder: (context, state) => const ForgotPassScreen(),
    ),
    GoRoute(
        path: '/main',
        builder: (context, state) {
          return const MainScreen();
        },
        routes: [
          GoRoute(
              path: 'bill',
              builder: (context, state) {
                return BillAddScreen(
                  bill: state.extra as BillModel,
                );
              },
              routes: [
                GoRoute(
                    path: 'select',
                    builder: (context, state) {
                      return const CtagorySelectScreen();
                    }),
                GoRoute(
                    path: 'image',
                    builder: (context, state) {
                      return FullImageScreen(imagePath: state.extra as String);
                    }),
              ]),
        ])
  ], redirect: (context, state) => _redirect(context, state));
}

_redirect(context, state) {
  if (!AuthGuard.isAuth &&
      state.location != '/register' &&
      state.location != '/' &&
      state.location != '/login' &&
      state.location != '/forgot-pass') {
    return '/'; // redirect to login
  } else {
    return null;
  }
}
