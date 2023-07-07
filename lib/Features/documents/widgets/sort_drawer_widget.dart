import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme.dart';
import '../cubit/documets_screen_cubit.dart';

class SortDrawerWidget extends StatelessWidget {
  const SortDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          transform: GradientRotation(0),
          colors: [
            Color(0xffdaedfd),
            Color.fromARGB(174, 231, 183, 239),
            Color(0xffdaedfd),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/parag.jpeg',
                      ),
                      fit: BoxFit.cover)),
              child: Text('Sortuj',
                  style: TextStyle(color: FigmaColorsAuth.white, fontSize: 20)),
            ),
            BlocBuilder<DocumetsScreenCubit, DocumetsScreenState>(
              builder: (context, state) {
                return Column(
                  children: [
                    RadioListTile(
                        title: Text(
                          "Data paragonu, od najnowszych",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        value: SortEnum.dateAddUp,
                        groupValue: state.sort,
                        onChanged: (value) {
                          context
                              .read<DocumetsScreenCubit>()
                              .selectSort(sort: SortEnum.dateAddUp);
                          context.pop();
                        }),
                    RadioListTile(
                      title: Text(
                        "Data paragonu, od najstarszych",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: SortEnum.dateAddDown,
                      groupValue: state.sort,
                      onChanged: (value) {
                        context
                            .read<DocumetsScreenCubit>()
                            .selectSort(sort: SortEnum.dateAddDown);
                        context.pop();
                      },
                    ),
                    const Divider(),
                    RadioListTile(
                      title: Text(
                        "Do końca gwarancji, malejąco",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: SortEnum.gwarancyDateDown,
                      groupValue: state.sort,
                      onChanged: (value) {
                        context
                            .read<DocumetsScreenCubit>()
                            .selectSort(sort: SortEnum.gwarancyDateDown);
                        context.pop();
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "Do końca gwarancji, rosnąco",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: SortEnum.gwarancyDateUp,
                      groupValue: state.sort,
                      onChanged: (value) {
                        context
                            .read<DocumetsScreenCubit>()
                            .selectSort(sort: SortEnum.gwarancyDateUp);
                        context.pop();
                      },
                    ),
                    const Divider(),
                    RadioListTile(
                      title: Text(
                        "Nazwa, A-Z",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: SortEnum.nameUp,
                      groupValue: state.sort,
                      onChanged: (value) {
                        context
                            .read<DocumetsScreenCubit>()
                            .selectSort(sort: SortEnum.nameUp);
                        context.pop();
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "Nazwa, Z-A",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: SortEnum.nameDown,
                      groupValue: state.sort,
                      onChanged: (value) {
                        context
                            .read<DocumetsScreenCubit>()
                            .selectSort(sort: SortEnum.nameDown);
                        context.pop();
                      },
                    ),
                    const Divider(),
                    RadioListTile(
                      title: Text(
                        "Cenie, rosnąco",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: SortEnum.priceUp,
                      groupValue: state.sort,
                      onChanged: (value) {
                        context
                            .read<DocumetsScreenCubit>()
                            .selectSort(sort: SortEnum.priceUp);
                        context.pop();
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "Cenie, malejąco",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: SortEnum.priceDown,
                      groupValue: state.sort,
                      onChanged: (value) {
                        context
                            .read<DocumetsScreenCubit>()
                            .selectSort(sort: SortEnum.priceDown);
                        context.pop();
                      },
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
