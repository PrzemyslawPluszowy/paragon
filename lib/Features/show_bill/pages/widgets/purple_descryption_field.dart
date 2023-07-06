import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class PurpleDescryptionField extends StatelessWidget {
  const PurpleDescryptionField({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        FigmaColorsAuth.darkFiolet,
        FigmaColorsAuth.darkFiolet.withOpacity(0.4),
        FigmaColorsAuth.darkFiolet.withOpacity(0)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Row(
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: value,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold))
          ]))
        ],
      ),
    );
  }
}
