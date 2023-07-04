import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:go_router/go_router.dart';
import 'package:rcp_new/Features/auth_screens/presentation/cubit/login_cubit.dart';
import 'package:rcp_new/core/data/bill_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/theme.dart';
import '../cubit/homescreen_cubit.dart';

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddRecipeCubit, AddRecipeState>(
        listener: (context, state) {
          if (state.imagePath != '') {
            context.push('/bill',
                extra: DocumentModel(
                    type: DocumentType.bill.toString().split('.').last,
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
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                transform: GradientRotation(180),
                colors: [
                  Color(0xffdaedfd),
                  Color(0xffdf9fea),
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0.5,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SvgPicture.asset('assets/appBar.svg',
                          fit: BoxFit.cover),
                    ),
                    title: Text('Simple Paragon',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white)),
                    expandedHeight: 200,
                    backgroundColor: FigmaColorsAuth.darkFiolet,
                  ),
                  state.isLoading
                      ? const SliverToBoxAdapter(
                          child: LinearProgressIndicator(),
                        )
                      : const SliverToBoxAdapter(
                          child: SizedBox(),
                        ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            context.read<AddRecipeCubit>().initCamera();
                          } else {
                            Fluttertoast.showToast(msg: 'Wkrótce dostępne');
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: FigmaColorsAuth.darkFiolet,
                                image: DecorationImage(
                                    image: index == 0
                                        ? const AssetImage('assets/parag.jpeg')
                                        : const AssetImage('assets/doc.jpeg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        transform: const GradientRotation(4.7),
                                        stops: const [
                                          0.15,
                                          0.5,
                                          1
                                        ],
                                        colors: [
                                          FigmaColorsAuth.darkFiolet,
                                          FigmaColorsAuth.darkFiolet
                                              .withOpacity(0.3),
                                          FigmaColorsAuth.darkFiolet
                                              .withOpacity(0.0)
                                        ]))),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Text(
                                  index == 1
                                      ? 'Skanuj dokument'
                                      : 'Skanuj paragon',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Colors.white, fontSize: 15)),
                            )
                          ],
                        ),
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
