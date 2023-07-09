import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rcp_new/Features/category_select/cubit/category_select_cubit.dart';
import 'package:rcp_new/core/data/bill_model.dart';
import 'package:rcp_new/core/theme/theme.dart';
import 'package:rcp_new/core/utils/extension.dart';

import '../../choise_mode_screen/cubit/homescreen_cubit.dart';
import '../cubit/bill_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_form_wiget.dart';
import '../widgets/menu_app_bar.dart';

class BillAddScreen extends StatefulWidget {
  const BillAddScreen({
    super.key,
    required this.bill,
  });
  final DocumentModel bill;

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
  late String? _type;
  late String? _task;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _companyNameController;
  late TextEditingController _taskController;
  late TextEditingController _dateController;
  double _guaranteeTime = 0;

  bool _isGuarantee = false;

  @override
  void initState() {
    super.initState();
    if (widget.bill.guaranteeDate != null) {
      _guaranteeTime = widget.bill.guaranteeDate!.toMonthhNumber();
    }
    _isGuarantee = widget.bill.guaranteeDate != null;
    _type = widget.bill.type;
    _id = widget.bill.billId;
    _userId = widget.bill.userId;
    _dateCreated = DateTime.fromMillisecondsSinceEpoch(
        widget.bill.dateCreated!.millisecondsSinceEpoch);
    _guaranteeDate = widget.bill.guaranteeDate == null
        ? null
        : widget.bill.guaranteeDate!.toDateTimeFromTimestep();
    _companyName = widget.bill.companyName ?? '';
    _category = widget.bill.category ?? 'Inne';
    _listItems = [...widget.bill.listItems ?? []];
    _price = widget.bill.price ?? 0;
    _imagePath = widget.bill.imagePath;
    _name = widget.bill.name ?? '';

    _nameController = TextEditingController();
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
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
    _taskController = TextEditingController();
    _taskController.addListener(() {
      _task = _taskController.text;
    });
    _dateController = TextEditingController(
        text: widget.bill.dateCreated!.dateToStringFromTimestep());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _companyNameController.dispose();
    _dateController.dispose();
    _taskController.dispose();

    super.dispose();
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
                child: CustomScrollView(slivers: [
                  CustomAppBar(
                    imagePath: _imagePath,
                    id: _id,
                  ),
                  MenuAppBarWidget(
                      imagePath: _imagePath,
                      formKey: _formKey,
                      type: _type,
                      category: _category,
                      companyName: _companyName,
                      dateCreated: _dateCreated,
                      guaranteeDate: _guaranteeDate,
                      listItems: _listItems,
                      name: _name,
                      price: _price,
                      userId: _userId,
                      id: _id),
                  SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                            keyboardType: TextInputType.text,
                            labelTextl: 'Nazwa',
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                  flex: 3,
                                  child: CustomTextFormField(
                                    onTap: () =>
                                        _showDatePic(context, _dateCreated),
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
                            mainAxisAlignment: _isGuarantee
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.end,
                            children: [
                              _isGuarantee
                                  ? Flexible(
                                      flex: 3,
                                      child: Slider(
                                        activeColor:
                                            FigmaColorsAuth.lightFiolet,
                                        value: _guaranteeTime,
                                        max: 60,
                                        divisions: 60,
                                        label:
                                            _guaranteeTime.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _guaranteeTime = value;
                                            _guaranteeDate =
                                                Jiffy.parseFromDateTime(
                                                        _dateCreated)
                                                    .add(
                                                        months: _guaranteeTime
                                                            .round())
                                                    .dateTime;
                                          });
                                        },
                                      ),
                                    )
                                  : const Text('Gwarancja?',
                                      style: TextStyle(
                                        color: FigmaColorsAuth.darknessFiolet,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      )),
                              Flexible(
                                child: Switch(
                                    activeColor: FigmaColorsAuth.darkFiolet,
                                    value: _isGuarantee,
                                    onChanged: (value) {
                                      setState(() {
                                        _isGuarantee = value;
                                      });
                                    }),
                              ),
                            ],
                          ),
                          const Center(
                              child: Text('Pozycje na paragonie:',
                                  style: TextStyle(
                                    color: FigmaColorsAuth.darkFiolet,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ))),
                          _listItems.isEmpty
                              ? IconButton(
                                  onPressed: () {
                                    _dialogAddPosition(context, _id);
                                  },
                                  icon: const FaIcon(
                                      FontAwesomeIcons.circlePlus,
                                      color: FigmaColorsAuth.darkFiolet,
                                      size: 35))
                              : ListView.builder(
                                  itemCount: _listItems.length + 1,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (index == _listItems.length) {
                                      return IconButton(
                                          onPressed: () {
                                            _dialogAddPosition(
                                              context,
                                              _id,
                                            );
                                          },
                                          icon: const FaIcon(
                                              FontAwesomeIcons.circlePlus,
                                              color: FigmaColorsAuth.darkFiolet,
                                              size: 35));
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: index.isEven
                                                      ? FigmaColorsAuth.black
                                                          .withOpacity(0.1)
                                                      : FigmaColorsAuth.black
                                                          .withOpacity(0.05)),
                                              child: ListTile(
                                                tileColor:
                                                    FigmaColorsAuth.darkFiolet,
                                                leading: CircleAvatar(
                                                    child: Text(
                                                  '$index',
                                                  style: const TextStyle(
                                                      color: FigmaColorsAuth
                                                          .darkFiolet),
                                                )),
                                                title: Text(_listItems[index]),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          _dialogEditPosition(
                                                              context,
                                                              _listItems[index],
                                                              index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.edit,
                                                            color: FigmaColorsAuth
                                                                .darkFiolet)),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _listItems.removeAt(
                                                                index);
                                                          });
                                                        },
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: FigmaColorsAuth
                                                                .darkFiolet)),
                                                    const Divider(height: 1),
                                                  ],
                                                ),
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
                ]),
              ));
        },
      ),
    );
  }

  Future<void> _dialogAddPosition(
    BuildContext context,
    String? id,
  ) {
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Dodaj pozycje do paragonu'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height:
                  id == null ? MediaQuery.of(context).size.height * 0.2 : null,
              child: Column(
                children: [
                  BlocBuilder<AddRecipeCubit, AddRecipeState>(
                    builder: (context, state) {
                      return Expanded(
                        flex: 10,
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 20 / 10,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 3,
                            ),
                            itemCount: state.listHelper.length,
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    String curretText = _taskController.text;
                                    String newText =
                                        '$curretText ${state.listHelper[index]} ';
                                    _taskController.text = newText;
                                  });
                                },
                                child: Chip(
                                    label: Text(state.listHelper[index])))),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 3,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pole nie moze byc puste';
                          }
                          return null;
                        },
                        controller: _taskController,
                        decoration: const InputDecoration(
                          hintText: 'Nazwa pozycji',
                        ),
                      ),
                    ),
                  ),
                ],
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
                      _listItems = [..._listItems, _task ?? ''];
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

  _showDatePic(
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
