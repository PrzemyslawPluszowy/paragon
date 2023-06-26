import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rcp_new/Features/AddBill/cubit/addbill_cubit.dart';
import 'package:rcp_new/core/theme/theme.dart';

import '../../choise_mode_screen/bill_model.dart';
import '../widgets/custom_form_wiget.dart';

class BillAddScreen extends StatelessWidget {
  const BillAddScreen({
    super.key,
    required this.bill,
  });

  final BillModel bill;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddbillCubit(
          categoryList: bill.categoryList,
          date: bill.date,
          imagePath: bill.imagePath,
          listItems: bill.listItems,
          listPrice: bill.listPrice,
          companyName: bill.companyName),
      child: BlocBuilder<AddbillCubit, AddbillState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: FigmaColorsAuth.darkFiolet,
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  FigmaColorsAuth.darkFiolet.withOpacity(0.7),
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: FigmaColorsAuth.white,
                                blurRadius: 30,
                                spreadRadius: 2,
                              )
                            ],
                            image: DecorationImage(
                                image: FileImage(File(state.imagePath!)),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          labelTextl: 'Nazwa',
                          onChanged: context.read<AddbillCubit>().nameInput),
                      CustomTextFormField(
                        value: bill.companyName == null
                            ? 'Nazwa firmy'
                            : bill.companyName!.name,
                        labelTextl: 'Nazwa firmy',
                      ),
                      CustomTextFormField(
                          onTap: () =>
                              context.read<AddbillCubit>().showDatePic(context),
                          isClickable: false,
                          labelTextl: 'Data',
                          keyboardType: TextInputType.datetime,
                          value: DateFormat('dd-MM-yyyy').format(state.date!)),
                      CustomTextFormField(
                          isClickable: false,
                          labelTextl: 'Category',
                          keyboardType: TextInputType.none,
                          value: bill.companyName != null
                              ? bill.companyName!.category
                              : 'category'),
                      const Center(
                          child: Text('Pozycje na paragonie:',
                              style: TextStyle(
                                color: FigmaColorsAuth.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ))),
                      bill.listItems.isEmpty
                          ? IconButton(
                              onPressed: () {},
                              icon: const FaIcon(FontAwesomeIcons.circlePlus,
                                  color: FigmaColorsAuth.white, size: 35))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: bill.listItems.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading:
                                            CircleAvatar(child: Text('$index')),
                                        title: Text(bill.listItems[index]),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.edit,
                                                    color: FigmaColorsAuth
                                                        .darkFiolet)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.delete,
                                                    color: FigmaColorsAuth
                                                        .darkFiolet)),
                                            const Divider(height: 1),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
