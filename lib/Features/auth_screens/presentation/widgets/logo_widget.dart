import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 67,
        width: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Paragony Gwarancyjne',
                    style: Theme.of(context)
                        .copyWith(
                            textTheme: const TextTheme(
                          bodyLarge: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ))
                        .textTheme
                        .bodyLarge),
                Transform.rotate(
                  angle: 0.19,
                  child: Icon(
                    Icons.calculate_outlined,
                    color: FigmaColorsAuth.white.withOpacity(0.6),
                    size: 45,
                  ),
                )
              ],
            ),
            Expanded(
              child: Row(children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Positioned(
                        child: SizedBox(
                          child: Divider(
                            height: 10,
                            color: FigmaColorsAuth.white.withOpacity(0.99),
                          ),
                        ),
                      ),
                      Positioned(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 10,
                            width: 10,
                            color: FigmaColorsAuth.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
