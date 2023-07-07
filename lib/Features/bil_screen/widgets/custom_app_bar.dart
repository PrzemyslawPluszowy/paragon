import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required String? imagePath,
    required this.id,
  }) : _imagePath = imagePath;

  final String? _imagePath;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      actions: [
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            FigmaColorsAuth.darkFiolet,
            FigmaColorsAuth.darkFiolet.withOpacity(0),
            FigmaColorsAuth.darkFiolet.withOpacity(0),
            FigmaColorsAuth.darkFiolet.withOpacity(0)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    context.go('/main');
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: FigmaColorsAuth.white,
                  )),
            ],
          ),
        )
      ],
      elevation: 20,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: id == null || id == ''
            ? Image.file(
                File(_imagePath!),
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: _imagePath!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    LinearProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
      ),
      expandedHeight: 200,
      backgroundColor: FigmaColorsAuth.darkFiolet,
    );
  }
}
