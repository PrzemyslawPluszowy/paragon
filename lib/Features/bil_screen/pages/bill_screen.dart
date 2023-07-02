import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rcp_new/Features/category_select/cubit/category_select_cubit.dart';
import 'package:rcp_new/core/data/bill_model.dart';
import 'package:rcp_new/core/theme/theme.dart';

import '../cubit/bill_cubit.dart';
import '../widgets/custom_form_wiget.dart';
import '../widgets/image_bill_widget.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String? _id;
  late String? _userId;
  late String _name;
  late DateTime _dateCreated;
  late DateTime? _guaranteeDate;
  late String _companyName;
  late String _category;
  List<String> _listItems = [];
  late double _price;
  late String? _imagePath;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _companyNameController;

  late TextEditingController _dateController;
  double guaranteeTime = 0;

  bool isGuarantee = false;

  @override
  void initState() {
    super.initState();
    _id = widget.bill.billId;
    _userId = widget.bill.userId;
    _dateCreated = DateTime.fromMillisecondsSinceEpoch(
        widget.bill.dateCreated!.millisecondsSinceEpoch);
    _guaranteeDate = widget.bill.guaranteeDate == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            widget.bill.guaranteeDate!.millisecondsSinceEpoch);
    _companyName = widget.bill.companyName ?? '';
    _category = widget.bill.category ?? 'Inne';
    _listItems = [...widget.bill.listItems ?? []];
    _price = widget.bill.price ?? 0;
    _imagePath = widget.bill.imagePath;

    _nameController = TextEditingController(text: widget.bill.name);
    _nameController.addListener(() {
      _name = _nameController.text;
    });
    _priceController = TextEditingController(text: _price.toString());

    _priceController.addListener(() {
      if (_priceController.text.isEmpty) {
        _price = 0;
      } else {
        _price = double.parse(_priceController.text);
      }
    });
    _categoryController = TextEditingController(text: _category);
    _categoryController.addListener(() {
      _category = _categoryController.text;
    });
    _companyNameController = TextEditingController(text: _companyName);
    _companyNameController.addListener(() {
      _companyName = _companyNameController.text;
    });
    _dateController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(
                widget.bill.dateCreated!.millisecondsSinceEpoch)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategorySelectCubit, CategorySelectState>(
      listener: (context, state) {
        _categoryController.text = state.selcetedCategory;
      },
      child: BlocBuilder<BillCubit, BillState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: FigmaColorsAuth.darkFiolet,
            body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ImageBillWidget(
                      save: () async {
                        if (_formKey.currentState!.validate()) {
                          final newBill = BillModel(
                            type: widget.bill.type,
                            category: _category,
                            companyName: _companyName,
                            dateCreated: Timestamp.fromDate(_dateCreated),
                            guaranteeDate: _guaranteeDate == null
                                ? null
                                : Timestamp.fromDate(_guaranteeDate!),
                            imagePath: _imagePath,
                            listItems: _listItems,
                            name: _name,
                            price: _price,
                            userId: _userId,
                            billId: _id,
                          );
                          if (_id != null && _id!.isNotEmpty) {
                            // TODO: update bill
                            // await context
                            //     .read<BillCubit>()
                            //     .updateBill(newBill, _id!);
                          } else {
                            await context.read<BillCubit>().saveBill(newBill);
                          }

                          if (context.mounted) {
                            context.go('/main');
                          }
                        }
                      },
                      imagePath: _imagePath!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      textEditingController: _nameController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Wpisz nazwę';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      labelTextl: 'Nazwa',
                      onChanged: (value) {
                        _name = value ?? '';
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            flex: 3,
                            child: CustomTextFormField(
                              onTap: () => showDatePic(context, _dateCreated),
                              isClickable: false,
                              labelTextl: 'Data',
                              keyboardType: TextInputType.datetime,
                              textEditingController: _dateController,
                            )),
                        Flexible(
                          child: CustomTextFormField(
                            keyboardType: TextInputType.number,
                            validator: (p0) {
                              if (!RegExp(r'^\d+(?:\.\d{1,2})?$')
                                  .hasMatch(p0!)) {
                                return 'Popraw';
                              }
                              return null;
                            },
                            textEditingController: _priceController,
                            labelTextl: 'Cena',
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      textEditingController: _companyNameController,
                      labelTextl: 'Nazwa firmy',
                    ),
                    CustomTextFormField(
                      onTap: () {
                        context.push('/main/bill/select',
                            extra: _categoryController);
                      },
                      isClickable: false,
                      labelTextl: 'Category',
                      keyboardType: TextInputType.none,
                      textEditingController: _categoryController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: isGuarantee
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        isGuarantee
                            ? Flexible(
                                flex: 3,
                                child: Slider(
                                  activeColor: FigmaColorsAuth.lightFiolet,
                                  value: guaranteeTime,
                                  max: 60,
                                  divisions: 60,
                                  label: guaranteeTime.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      guaranteeTime = value;
                                      _guaranteeDate =
                                          Jiffy.parseFromDateTime(_dateCreated)
                                              .add(
                                                  months: guaranteeTime.round())
                                              .dateTime;
                                    });
                                  },
                                ),
                              )
                            : const Text('Gwarancja?',
                                style: TextStyle(
                                  color: FigmaColorsAuth.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                )),
                        Flexible(
                          child: Switch(
                              activeColor: FigmaColorsAuth.white,
                              value: isGuarantee,
                              onChanged: (value) {
                                setState(() {
                                  isGuarantee = value;
                                });
                              }),
                        ),
                      ],
                    ),
                    const Center(
                        child: Text('Pozycje na paragonie:',
                            style: TextStyle(
                              color: FigmaColorsAuth.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ))),
                    _listItems.isEmpty
                        ? IconButton(
                            onPressed: () {
                              _dialogAddPosition(context);
                            },
                            icon: const FaIcon(FontAwesomeIcons.circlePlus,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 35))
                        : ListView.builder(
                            itemCount: _listItems.length + 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index == _listItems.length) {
                                return IconButton(
                                    onPressed: () {
                                      _dialogAddPosition(context);
                                    },
                                    icon: const FaIcon(
                                        FontAwesomeIcons.circlePlus,
                                        color: FigmaColorsAuth.white,
                                        size: 35));
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        tileColor: FigmaColorsAuth.white,
                                        leading:
                                            CircleAvatar(child: Text('$index')),
                                        title: Text(_listItems[index]),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _dialogEditPosition(context,
                                                      _listItems[index], index);
                                                },
                                                icon: const Icon(Icons.edit,
                                                    color: FigmaColorsAuth
                                                        .darkFiolet)),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _listItems.removeAt(index);
                                                  });
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
            ),
          );
        },
      ),
    );
  }

  Future<void> _dialogAddPosition(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
        context: context,
        builder: (context) {
          String taskName = '';
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
                    setState(() {
                      _listItems = [..._listItems, taskName];
                    });
                    context.pop();
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> _dialogEditPosition(
      BuildContext context, String stringFromList, int index) {
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
            value: BlocProvider.of<BillCubit>(context),
            child: AlertDialog(
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
                    stringFromList = value;
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
                      setState(() {
                        _listItems[index] = stringFromList;
                      });

                      context.pop();
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  showDatePic(
    context,
    DateTime dateTime,
  ) async {
    final date = await showDatePicker(
        // locale: const Locale('pl', 'PL'),
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    setState(() {
      _dateCreated = date!;
      _dateController.text = DateFormat('dd-MM-yyyy').format(_dateCreated);
    });
  }
}
