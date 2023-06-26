import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/core/theme/theme.dart';
import 'package:rcp_new/shared/global_widget/responsive_widget.dart';
import '../cubit/register_cubit.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_send_button.dart';
import '../widgets/error_box_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/one_line_rich_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const ResponsiveWidget(phone: LoginPhoneScreen()),
    ));
  }
}

class LoginPhoneScreen extends StatelessWidget {
  const LoginPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                radius: 1.5,
                stops: [0.1, 0.7, 0.9],
                center: Alignment(0, 1.1),
                colors: [
                  FigmaColorsAuth.superLightFiolet,
                  FigmaColorsAuth.mediumFiolet,
                  FigmaColorsAuth.darkFiolet,
                ])),
        child: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              width: width,
              height: MediaQuery.of(context).size.height,
              child: BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state.isSucces) {
                    GoRouter.of(context).go('/');
                    Fluttertoast.showToast(
                        msg: "Register succes",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: FigmaColorsAuth.mediumFiolet,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      AuthLogo(width: width),
                      const Spacer(),
                      Text('Register',
                          style: Theme.of(context)
                              .copyWith(
                                  textTheme: const TextTheme(
                                      displayMedium: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w400)))
                              .textTheme
                              .displayMedium),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomFormField(
                        isError: state.nameError,
                        width: width,
                        label: 'Name',
                        insideIcon: Icons.person,
                        onChanged: (value) {
                          context.read<RegisterCubit>().nameChanged(value);
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomFormField(
                        isError: state.emailError,
                        width: width,
                        label: 'Email',
                        insideIcon: Icons.email,
                        onChanged: (value) {
                          context.read<RegisterCubit>().emailChanged(value);
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomFormField(
                        isError: state.passwordError,
                        width: width,
                        label: 'Password',
                        insideIcon: Icons.lock,
                        onChanged: (value) {
                          context.read<RegisterCubit>().passwordChanged(value);
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomFormField(
                        isError: state.rePasswordError,
                        width: width,
                        label: 'Re-password',
                        insideIcon: Icons.lock,
                        onChanged: (value) {
                          context
                              .read<RegisterCubit>()
                              .rePasswordChanged(value);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      state.errorText != null
                          ? ErrorBoxWidget(errorText: '${state.errorText}')
                          : const SizedBox(),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomSendButton(
                        isLoading: state.isSending,
                        width: width,
                        label: 'Make an account',
                        onPressed: () {
                          context.read<RegisterCubit>().subbmitForm();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.go('/');
                        },
                        child: const CustomRichText(
                            label: 'Already have an account? ',
                            boldText: 'Login'),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
