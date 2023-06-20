import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/Features/Auth/presentation/pages/forget_pass_screen.dart';

import 'package:rcp_new/Features/Auth/presentation/pages/register_screen.dart';
import 'package:rcp_new/Features/MainScreen/presentation/pages/main_screen.dart';
import 'package:rcp_new/core/routing/auth_guard.dart';
import 'package:rcp_new/main.dart';

import '../../Features/Auth/presentation/pages/login_screen.dart';
import '../../Features/Auth/repository.dart';

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
      path: '/main',
      builder: (context, state) {
        return const MainScreen();
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
    )
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
