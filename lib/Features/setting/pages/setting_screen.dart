import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcp_new/Features/setting/cubit/setting_cubit.dart';

import '../../../../core/theme/theme.dart';
import '../../../core/utils/dialog_confirm.dart';

class GridList {
  final String title;
  final IconData icon;
  final Function onTap;
  const GridList({
    required this.onTap,
    required this.title,
    required this.icon,
  });
}

List<GridList> menu = [
  GridList(
      onTap: (BuildContext context) {
        DialogConfirm.confirmDialog(
          content: 'Czy na pewno chcesz się wylogować?',
          context: context,
          title: 'Wyloguj',
          onConfirm: () {
            context.read<SettingCubit>().logOut();
          },
        );
      },
      title: 'Wyloguj',
      icon: Icons.logout),
  GridList(onTap: () {}, title: 'O aplikacji', icon: Icons.info),
  // delete account
  GridList(
      onTap: (BuildContext context) {
        // context.read<SettingCubit>().delteAccount(context);
        DialogConfirm.confirmDialog(
          content: 'Czy na pewno chcesz usunąć konto?',
          context: context,
          title: 'Usuń konto',
          onConfirm: () {
            context.read<SettingCubit>().delteAccount(context);
          },
        );
      },
      title: 'Usuń konto',
      icon: Icons.delete),
  GridList(
      onTap: (BuildContext context) {
        // context.read<SettingCubit>().changePass();
        DialogConfirm.confirmDialog(
          content: 'Czy na pewno chcesz zmienić hasło?',
          context: context,
          title: 'Zmień hasło',
          onConfirm: () {
            context.read<SettingCubit>().changePass();
          },
        );
      },
      title: 'Zmień hasło',
      icon: Icons.lock),
  GridList(
      onTap: (BuildContext context) async {
        // await context.read<SettingCubit>().deleteAllDatta(context);
        DialogConfirm.confirmDialog(
          content: 'Czy na pewno chcesz usunąć dane?',
          context: context,
          title: 'Usuń dane',
          onConfirm: () {
            context.read<SettingCubit>().deleteAllDatta(context);
          },
        );
      },
      title: 'Wykasuj dane',
      icon: Icons.delete_forever),
  //exportuj dane
  GridList(
    onTap: (BuildContext context) async {
      DialogConfirm.confirmDialog(
          context: context,
          title: 'Eksportuj dane',
          content: 'Eksportowanie danych może zająć chwilę,bądź cierpliwy.',
          onConfirm: () {
            context.read<SettingCubit>().createPdf();
          });
    },
    title: 'Eksportuj dane',
    icon: Icons.upload_file,
  ),
];

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return CustomScrollView(slivers: [
              SliverAppBar(
                elevation: 0.5,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('assets/doc.jpeg', fit: BoxFit.cover),
                ),
                title: Text('',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white)),
                expandedHeight: 150,
                backgroundColor: FigmaColorsAuth.darkFiolet,
              ),
              state.isBusyl || state.status != ''
                  ? SliverToBoxAdapter(
                      child: Column(
                      children: [
                        state.isBusyl
                            ? const LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    FigmaColorsAuth.darkFiolet),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: FigmaColorsAuth.darkFiolet,
                            border:
                                Border.all(color: FigmaColorsAuth.darkFiolet),
                          ),
                          child: Center(
                            child: Text(state.status,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                      ],
                    ))
                  : const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 0,
                      ),
                    ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid.builder(
                  itemCount: menu.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 5 / 4),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        !state.isBusyl
                            ? await menu[index].onTap(context)
                            : null;
                      },
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              menu[index].onTap();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [
                                      FigmaColorsAuth.darkFiolet,
                                      FigmaColorsAuth.darkFiolet
                                          .withOpacity(0.3),
                                      FigmaColorsAuth.darkFiolet
                                          .withOpacity(0.0)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
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
                          Positioned.fill(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  menu[index].icon,
                                  color:
                                      const Color.fromARGB(143, 255, 255, 255),
                                  size: 80,
                                ),
                                Text(menu[index].title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ]);
          },
        ),
      ),
    );
  }
}
