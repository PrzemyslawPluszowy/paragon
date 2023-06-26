part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    required this.isSucces,
    this.errorText,
    required this.isSending,
    required this.unimplementedError,
    required this.nameError,
    required this.emailError,
    required this.passwordError,
    required this.rePasswordError,
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
  });
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final bool nameError;
  final bool emailError;
  final bool passwordError;
  final bool rePasswordError;
  final bool? unimplementedError;
  final String? errorText;
  final bool isSending;
  final bool isSucces;

  factory RegisterState.initial() {
    return const RegisterState(
      name: '',
      email: '',
      password: '',
      rePassword: '',
      isSending: false,
      emailError: false,
      nameError: false,
      passwordError: false,
      rePasswordError: false,
      unimplementedError: null,
      isSucces: false,
    );
  }
  @override
  List<Object?> get props => [
        name,
        email,
        password,
        rePassword,
        isSending,
        errorText,
        unimplementedError,
        nameError,
        emailError,
        passwordError,
        rePasswordError
      ];

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? rePassword,
    bool? nameError,
    bool? emailError,
    bool? passwordError,
    bool? rePasswordError,
    bool? unimplementedError,
    String? errorText,
    bool? isSending,
    bool? isSucces,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      rePasswordError: rePasswordError ?? this.rePasswordError,
      isSending: isSending ?? this.isSending,
      errorText: errorText,
      unimplementedError: unimplementedError,
      isSucces: isSucces ?? this.isSucces,
    );
  }
}
