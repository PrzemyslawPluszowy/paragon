import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/bill_model.dart';
import '../../../core/theme/theme.dart';

SliverAppBar billAppBar(BuildContext context, DocumentModel documentModel) {
  return SliverAppBar(
    forceElevated: true,
    actions: [
      Container(
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
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: FigmaColorsAuth.white,
                )),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Nazwa paragonu:',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400)),
              TextSpan(
                  text: '  ${documentModel.name}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ]))
          ],
        ),
      )
    ],
    elevation: 20,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      background: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: documentModel.imagePath!,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            LinearProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
    expandedHeight: 200,
    backgroundColor: FigmaColorsAuth.darkFiolet,
  );
}
