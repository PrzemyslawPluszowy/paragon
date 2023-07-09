import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/core/theme/theme.dart';
import 'package:rcp_new/shared/global_widget/responsive_widget.dart';
import '../cubit/login_cubit.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_send_button.dart';
import '../widgets/error_box_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/one_line_rich_text.dart';
import '../widgets/social_register_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      AuthLogo(width: width),
                      const Spacer(),
                      Text('Zaloguj się',
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
                      const SizedBox(
                        height: 5,
                      ),
                      CustomFormField(
                        isError: state.emailError,
                        width: width,
                        label: 'Email',
                        insideIcon: Icons.email,
                        onChanged: (value) {
                          context.read<LoginCubit>().emailChanged(value);
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
                          context.read<LoginCubit>().passwordChanged(value);
                        },
                      ),
                      const SizedBox(
                        height: 5,
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
                        width: width,
                        label: 'Zaloguj',
                        onPressed: () {
                          context.read<LoginCubit>().subbmitForm();
                        },
                        isLoading: state.isSending,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 15),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              context.go('/forgot-pass');
                            },
                            child: const CustomRichText(
                                label: "Zapomniałes hasła?",
                                boldText: ' Click'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Text('Login with...',
                          style: Theme.of(context)
                              .copyWith(
                                  textTheme: const TextTheme(
                                      displaySmall: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400)))
                              .textTheme
                              .displaySmall),
                      const SizedBox(
                        height: 10,
                      ),
                      SocialRegisterWidget(width: width),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.go('/register');
                        },
                        child: const CustomRichText(
                            label: "Nie masz konta?",
                            boldText: ' Zarejestruj się'),
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
