import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class CustomSendButton extends StatelessWidget {
  const CustomSendButton({
    super.key,
    required this.width,
    required this.label,
    required this.onPressed,
    required this.isLoading,
  });
  final bool isLoading;
  final double width;
  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      height: 50,
      child: FilledButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: isLoading
                  ? MaterialStateProperty.all<Color>(
                      FigmaColorsAuth.lightGrey.withOpacity(0.5))
                  : MaterialStateProperty.all<Color>(
                      FigmaColorsAuth.darknessFiolet)),
          onPressed: isLoading ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: CircularProgressIndicator(
                        color: FigmaColorsAuth.white,
                      ),
                    )
                  : const SizedBox(),
              Text(
                label,
                style: Theme.of(context)
                    .copyWith(
                        textTheme: const TextTheme(
                            bodyLarge: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)))
                    .textTheme
                    .bodyLarge,
              ),
            ],
          )),
    );
  }
}
