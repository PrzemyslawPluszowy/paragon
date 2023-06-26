import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/routing/auth_guard.dart';
import '../../repository.dart';

part 'auth_routing_state.dart';

class AuthRoutingCubit extends Cubit<AuthRoutingState> {
  AuthRoutingCubit({required this.authRepository}) : super(AuthRoutingLogut());
  final AuthRepository authRepository;

// auto login and protect web pages
  void initAuthGuardRouting() {
    authRepository.isUserLoggedIn().listen((event) {
      if (event != null) {
        AuthGuard.isAuth = true;
        emit(AuthRoutingLogin());
      } else {
        AuthGuard.isAuth = false;
        emit(AuthRoutingLogut());
      }
    });
  }
}
