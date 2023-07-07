import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/Features/documents/cubit/documets_screen_cubit.dart';

import '../../../core/data/bill_model.dart';
import '../../../core/theme/theme.dart';

class ButtonMenuWidget extends StatelessWidget {
  const ButtonMenuWidget({
    super.key,
    required this.documentModel,
  });

  final DocumentModel documentModel;
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
              onPressed: () {
                if (documentModel.billId != null) {
                  context
                      .read<DocumetsScreenCubit>()
                      .deleteDocument(id: documentModel.billId!);
                }
                context.go('/main');
              },
              icon: const Icon(
                Icons.delete_outline_sharp,
                color: Colors.white,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                context.push('/bill', extra: documentModel);
              },
              icon: const Icon(
                Icons.edit_note_outlined,
                color: Colors.white,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                context.pushNamed('image', queryParameters: {
                  'image': documentModel.imagePath,
                  'id': documentModel.billId,
                });
              },
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
