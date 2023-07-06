import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class ButtonMenuWidget extends StatelessWidget {
  const ButtonMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(color: FigmaColorsAuth.darkFiolet, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5))
      ]),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outline_sharp,
                color: Colors.white,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_note_outlined,
                color: Colors.white,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.fullscreen,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
    );
  }
}
