import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rcp_new/core/theme/theme.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({super.key, required this.imagePath, required this.id});
  final String imagePath;
  final String? id;

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
        body: Center(
          child: id == null || id == ''
              ? Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                )
              : CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ));
  }
}
