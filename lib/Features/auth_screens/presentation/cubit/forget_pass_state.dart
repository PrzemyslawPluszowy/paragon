part of 'forget_pass_cubit.dart';

class ForgetPassState extends Equatable {
  const ForgetPassState(
      {required this.email,
      required this.boxText,
      required this.isSending,
      required this.isSent});

  final String email;
  final String? boxText;
  final bool isSending;
  final bool isSent;

  @override
  List<Object?> get props => [email, isSending, isSent, boxText];

  factory ForgetPassState.initial() {
    return const ForgetPassState(
        email: '', boxText: null, isSending: false, isSent: false);
  }
  ForgetPassState copyWith(
      {String? email, String? boxText, bool? isSending, bool? isSent}) {
    return ForgetPassState(
        email: email ?? this.email,
        isSending: isSending ?? this.isSending,
        isSent: isSent ?? this.isSent,
        boxText: boxText ?? this.boxText);
  }
}
