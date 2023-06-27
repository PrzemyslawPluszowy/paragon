import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rcp_new/Features/choise_mode_screen/cubit/homescreen_cubit.dart';
import 'package:rcp_new/core/theme/theme.dart';

import '../bill_model.dart';
import '../widgets/custom_form_wiget.dart';

class BillAddScreen extends StatefulWidget {
  const BillAddScreen({
    super.key,
    required this.bill,
  });

  final BillModel bill;

  @override
  State<BillAddScreen> createState() => _BillAddScreenState();
}

class _BillAddScreenState extends State<BillAddScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRecipeCubit, AddRecipeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: FigmaColorsAuth.darkFiolet,
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Stack(children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: FigmaColorsAuth.darkFiolet.withOpacity(0.3),
                            width: 2,
                          ),
                          image: DecorationImage(
                              image: FileImage(File(state.imagePath)),
                              fit: BoxFit.cover),
                        ),
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
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<AddRecipeCubit>()
                                        .restetState();
                                    context.pop();
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.chevronLeft,
                                    color: FigmaColorsAuth.white,
                                    size: 25,
                                  ),
                                ),
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
                                        onPressed: () {},
                                        icon: const FaIcon(
                                            FontAwesomeIcons.expand,
                                            color: FigmaColorsAuth.white,
                                            size: 25)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: FigmaColorsAuth.darkFiolet,
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () async {},
                                        icon: const FaIcon(
                                            FontAwesomeIcons.floppyDisk,
                                            color: FigmaColorsAuth.white,
                                            size: 25)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 3,
                      child: CustomTextFormField(
                          keyboardType: TextInputType.number,
                          labelTextl: 'Nazwa',
                          onChanged: context.read<AddRecipeCubit>().nameInput),
                    ),
                    Flexible(
                      child: CustomTextFormField(
                          value: state.listPrice.isEmpty
                              ? '0'
                              : state.listPrice.first,
                          labelTextl: 'Cena',
                          onChanged: context.read<AddRecipeCubit>().nameInput),
                    ),
                  ],
                ),
                CustomTextFormField(
                  value: widget.bill.companyName == null
                      ? 'Nazwa firmy'
                      : widget.bill.companyName!.name,
                  labelTextl: 'Nazwa firmy',
                ),
                CustomTextFormField(
                    onTap: () =>
                        context.read<AddRecipeCubit>().showDatePic(context),
                    isClickable: false,
                    labelTextl: 'Data',
                    keyboardType: TextInputType.datetime,
                    value: DateFormat('dd-MM-yyyy').format(state.date)),
                CustomTextFormField(
                    isClickable: false,
                    labelTextl: 'Category',
                    keyboardType: TextInputType.none,
                    value: widget.bill.companyName != null
                        ? widget.bill.companyName!.category
                        : 'category'),
                const Center(
                    child: Text('Pozycje na paragonie:',
                        style: TextStyle(
                          color: FigmaColorsAuth.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ))),
                widget.bill.listItems.isEmpty
                    ? IconButton(
                        onPressed: () {
                          _dialogAddPosition(context);
                        },
                        icon: const FaIcon(FontAwesomeIcons.circlePlus,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 35))
                    : ListView.builder(
                        itemCount: state.listItems.length + 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == state.listItems.length) {
                            return IconButton(
                                onPressed: () {
                                  _dialogAddPosition(context);
                                },
                                icon: const FaIcon(FontAwesomeIcons.circlePlus,
                                    color: FigmaColorsAuth.white, size: 35));
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: FigmaColorsAuth.white,
                                    leading:
                                        CircleAvatar(child: Text('$index')),
                                    title: Text(state.listItems[index]),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _dialogEditPosition(
                                                  context,
                                                  state.listItems[index],
                                                  index);
                                            },
                                            icon: const Icon(Icons.edit,
                                                color: FigmaColorsAuth
                                                    .darkFiolet)),
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<AddRecipeCubit>()
                                                  .deleteTask(index);
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: FigmaColorsAuth
                                                    .darkFiolet)),
                                        const Divider(height: 1),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        })
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _dialogAddPosition(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String taskName = '';
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj pozycje do paragonu'),
          content: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pole nie moze byc piuste';
                }
                return null;
              },
              controller: TextEditingController(),
              decoration: const InputDecoration(
                hintText: 'Nazwa pozycji',
              ),
              onChanged: (value) {
                setState(() {
                  taskName = value;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Anuluj'),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Dodaj'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AddRecipeCubit>().addTask(taskName);
                  context.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogEditPosition(
      BuildContext context, String stringFromList, int index) {
    final formKey = GlobalKey<FormState>();

    String taskName = '';
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj pozycje do paragonu'),
          content: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pole nie moze byc piuste';
                }
                return null;
              },
              controller: TextEditingController(text: stringFromList),
              decoration: const InputDecoration(
                hintText: 'Nazwa pozycji',
              ),
              onChanged: (value) {
                setState(() {
                  taskName = value;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Anuluj'),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Dodaj'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AddRecipeCubit>().editTask(taskName, index);
                  context.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
