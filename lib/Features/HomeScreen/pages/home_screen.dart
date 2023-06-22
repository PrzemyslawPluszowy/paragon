import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rcp_new/Features/HomeScreen/cubit/homescreen_cubit.dart';

import '../../../../core/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {},
                  icon: const FaIcon(FontAwesomeIcons.powerOff,
                      color: FigmaColorsAuth.white, size: 20))
            ],
            title: const Text('Mr.Recipe',
                style: TextStyle(
                  color: FigmaColorsAuth.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            bottomOpacity: 0.0,
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
            toolbarHeight: 30,
            backgroundColor: FigmaColorsAuth.darkFiolet),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 30,
            child: Column(children: [
              Container(
                decoration:
                    const BoxDecoration(color: FigmaColorsAuth.darkFiolet),
                width: double.infinity,
                height: 80,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    context.read<HomescreenCubit>().initCamera();
                  },
                  icon: const FaIcon(FontAwesomeIcons.camera,
                      color: FigmaColorsAuth.darkFiolet, size: 100)),
              const Spacer(
                flex: 2,
              ),
            ]),
          ),
        ));
  }
}
