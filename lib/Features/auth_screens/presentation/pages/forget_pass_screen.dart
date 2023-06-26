import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/core/theme/theme.dart';
import 'package:rcp_new/shared/global_widget/responsive_widget.dart';
import '../cubit/forget_pass_cubit.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_send_button.dart';
import '../widgets/error_box_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/one_line_rich_text.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const ResponsiveWidget(phone: ForgetPhoneScreen()),
    ));
  }
}

class ForgetPhoneScreen extends StatelessWidget {
  const ForgetPhoneScreen({super.key});

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
              child: BlocBuilder<ForgetPassCubit, ForgetPassState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      AuthLogo(width: width),
                      const Spacer(),
                      Text('Write yor email',
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
                        height: 10,
                      ),
                      CustomFormField(
                        isError: state.boxText != null,
                        width: width,
                        label: 'Email',
                        insideIcon: Icons.email,
                        onChanged: (value) {
                          context.read<ForgetPassCubit>().emailChanged(value);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      state.boxText != null
                          ? ErrorBoxWidget(errorText: '${state.boxText}')
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      CustomSendButton(
                          isLoading: state.isSending,
                          width: width,
                          label: state.isSent ? 'Back to login' : 'Send email',
                          onPressed: state.isSent
                              ? () {
                                  context.go('/login');
                                  context.read<ForgetPassCubit>().resetState();
                                }
                              : () {
                                  context
                                      .read<ForgetPassCubit>()
                                      .sendForgotPassword();
                                }),
                      const Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/login');
                        },
                        child: const CustomRichText(
                            label: "Back to login?", boldText: 'Click'),
                      ),
                      const Spacer(
                        flex: 1,
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
