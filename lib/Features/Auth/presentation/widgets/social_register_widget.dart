import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/theme.dart';
import '../cubit/login_cubit.dart';

class SocialRegisterWidget extends StatelessWidget {
  const SocialRegisterWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.4,
      decoration: BoxDecoration(
          color: FigmaColorsAuth.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // TODO: Uncomment when Facebook login is implemented
          // IconButton(
          //   onPressed: () {
          //     context.read<LoginCubit>().signInFacebook();
          //   },
          //   icon: const FaIcon(
          //     FontAwesomeIcons.facebook,
          //     size: 40,
          //     color: Color.fromARGB(255, 0, 138, 251),
          //   ),
          // ),
          IconButton(
              onPressed: () {
                context.read<LoginCubit>().signInGoogle();
              },
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Color.fromARGB(255, 254, 17, 0),
                size: 40,
              )),
          //TODO: Uncomment when Apple login is implemented
          // IconButton(
          //     onPressed: () {},
          //     icon: const FaIcon(
          //       FontAwesomeIcons.apple,
          //       size: 40,
          //     )),
        ],
      ),
    );
  }
}
