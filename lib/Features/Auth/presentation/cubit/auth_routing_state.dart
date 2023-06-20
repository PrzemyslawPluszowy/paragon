part of 'auth_routing_cubit.dart';

abstract class AuthRoutingState extends Equatable {
  const AuthRoutingState();

  @override
  List<Object> get props => [];
}

class AuthRoutingLogut extends AuthRoutingState {}

class AuthRoutingLogin extends AuthRoutingState {}
