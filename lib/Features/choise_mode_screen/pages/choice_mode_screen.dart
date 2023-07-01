import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/core/data/bill_model.dart';

import '../../../../core/theme/theme.dart';
import '../cubit/homescreen_cubit.dart';

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

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
        body: BlocListener<AddRecipeCubit, AddRecipeState>(
          listener: (context, state) {
            if (state.imagePath != '') {
              context.push('/main/bill',
                  extra: BillModel(
                      dateCreated: state.date,
                      listItems: state.listItems,
                      price: state.listPrice.isEmpty
                          ? 0
                          : double.tryParse(state.listPrice.first),
                      imagePath: state.imagePath,
                      companyName: state.companyName?.name,
                      category: state.companyName?.category));
            }
          },
          child: BlocBuilder<AddRecipeCubit, AddRecipeState>(
            builder: (context, state) {
              return state.isLoading
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black45,
                      child: const Center(child: CircularProgressIndicator()))
                  : SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 30,
                        child: Column(children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: FigmaColorsAuth.darkFiolet),
                            width: double.infinity,
                            height: 80,
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                context.read<AddRecipeCubit>().initCamera();
                              },
                              icon: const FaIcon(FontAwesomeIcons.camera,
                                  color: FigmaColorsAuth.darkFiolet,
                                  size: 100)),
                          const Spacer(
                            flex: 2,
                          ),
                        ]),
                      ),
                    );
            },
          ),
        ));
  }
}
