import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/Features/bil_screen/cubit/bill_cubit.dart';
import '../../../core/theme/theme.dart';

class ImageBillWidget extends StatelessWidget {
  const ImageBillWidget({
    super.key,
    required this.save,
    required this.imagePath,
  });
  final Function() save;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<BillCubit, BillState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: FigmaColorsAuth.darkFiolet.withOpacity(0.3),
                    width: 2,
                  ),
                  image: DecorationImage(
                      image: FileImage(File(imagePath)), fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: FigmaColorsAuth.darkFiolet,
                  child: BlocBuilder<BillCubit, BillState>(
                    builder: (context, state) {
                      return Center(
                        child: state.isLoading
                            ? const CircularProgressIndicator()
                            : IconButton(
                                onPressed: () async {
                                  if (context.mounted) {
                                    context.go('/main');
                                  }
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: FigmaColorsAuth.white,
                                  size: 25,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: FigmaColorsAuth.darkFiolet,
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              context.push('/main/bill/image',
                                  extra: imagePath);
                            },
                            icon: const FaIcon(FontAwesomeIcons.expand,
                                color: FigmaColorsAuth.white, size: 25)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: FigmaColorsAuth.darkFiolet,
                      child: BlocBuilder<BillCubit, BillState>(
                        builder: (context, state) {
                          return Center(
                            child: state.isLoading
                                ? const CircularProgressIndicator(
                                    color: FigmaColorsAuth.white,
                                  )
                                : IconButton(
                                    onPressed: save,
                                    icon: const FaIcon(
                                        FontAwesomeIcons.floppyDisk,
                                        color: FigmaColorsAuth.white,
                                        size: 25)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    ]);
  }
}
