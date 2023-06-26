import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rcp_new/core/theme/theme.dart';

class ErrorBoxWidget extends StatelessWidget {
  const ErrorBoxWidget({
    super.key,
    required this.errorText,
  });
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Flexible(
                child: FaIcon(
                  FontAwesomeIcons.triangleExclamation,
                  color: FigmaColorsAuth.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(errorText ?? '',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .copyWith(
                            textTheme: const TextTheme(
                                bodySmall: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)))
                        .textTheme
                        .bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
