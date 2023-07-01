import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rcp_new/Features/category_select/cubit/category_select_cubit.dart';

class CtagorySelectScreen extends StatelessWidget {
  const CtagorySelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
              width: double.infinity,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Wyszukaj',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  context.read<CategorySelectCubit>().searchCategory(value);
                },
              )),
        ),
        body: BlocBuilder<CategorySelectCubit, CategorySelectState>(
          builder: (context, state) {
            return Center(
                child: ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (
                      context,
                      index,
                    ) =>
                        InkWell(
                          onTap: () {
                            context
                                .read<CategorySelectCubit>()
                                .setCategories(state.categories[index]);
                            context.pop();
                          },
                          child: ListTile(
                              tileColor: index.isOdd
                                  ? const Color.fromARGB(255, 235, 235, 234)
                                  : Colors.white,
                              title: Text(
                                state.categories[index],
                              )),
                        )));
          },
        ));
  }
}
