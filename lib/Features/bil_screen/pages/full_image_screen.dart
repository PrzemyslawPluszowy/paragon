import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rcp_new/core/theme/theme.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FigmaColorsAuth.darkFiolet,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      backgroundColor: FigmaColorsAuth.darkFiolet,
      body: Container(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
