import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    Key? key,
    required this.label,
    required this.boldText,
  }) : super(key: key);
  final String label;
  final String boldText;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: label,
          style: Theme.of(context)
              .copyWith(
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          color: FigmaColorsAuth.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)))
              .textTheme
              .bodyLarge),
      TextSpan(
          text: boldText,
          style: Theme.of(context)
              .copyWith(
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)))
              .textTheme
              .bodyLarge!
              .copyWith(color: FigmaColorsAuth.white))
    ]));
  }
}
