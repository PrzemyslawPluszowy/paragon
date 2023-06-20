part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(
      {required this.email,
      required this.password,
      required this.emailError,
      required this.passwordError,
      required this.unimplementedError,
      required this.errorText,
      required this.isSending,
      required this.isSucces});

  final String email;
  final String password;
  final bool emailError;
  final bool passwordError;
  final bool? unimplementedError;
  final String? errorText;
  final bool isSending;
  final bool isSucces;
  @override
  List<Object?> get props => [
        email,
        password,
        emailError,
        passwordError,
        unimplementedError,
        errorText,
        isSending,
        isSucces
      ];

  factory LoginState.initial() {
    return const LoginState(
        email: '',
        password: '',
        emailError: false,
        passwordError: false,
        unimplementedError: null,
        errorText: null,
        isSending: false,
        isSucces: false);
  }
  LoginState copyWith({
    String? email,
    String? password,
    bool? emailError,
    bool? passwordError,
    bool? unimplementedError,
    String? errorText,
    bool? isSending,
    bool? isSucces,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      unimplementedError: unimplementedError ?? this.unimplementedError,
      errorText: errorText,
      isSending: isSending ?? this.isSending,
      isSucces: isSucces ?? this.isSucces,
    );
  }
}
