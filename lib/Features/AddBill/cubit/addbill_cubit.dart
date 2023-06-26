import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rcp_new/core/data/model/company_model.dart';

part 'addbill_state.dart';

class AddbillCubit extends Cubit<AddbillState> {
  AddbillCubit(
      {required this.date,
      required this.imagePath,
      required this.companyName,
      required this.listItems,
      required this.listPrice,
      required this.categoryList})
      : super(AddbillState(
            date: date,
            imagePath: imagePath,
            companyName: companyName,
            listItems: listItems,
            listPrice: listPrice,
            categoryList: categoryList,
            isLoading: false,
            title: ''));

  DateTime date;
  final String? imagePath;
  final CompanyModel? companyName;
  final List<String>? listItems;
  final List<String>? listPrice;
  final List<String>? categoryList;

  showDatePic(context) async {
    date = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100)) ??
        DateTime.now();
    emit(state.copyWith(
        date: date,
        isLoading: false,
        imagePath: imagePath,
        companyName: companyName,
        listItems: listItems,
        listPrice: listPrice,
        categoryList: categoryList));
  }

  addTask(String taskName) {
    state.listItems!.add(taskName);
    emit(state.copyWith(
      listItems: listItems,
    ));
  }

  nameInput(String value) {
    emit(state.copyWith(title: value));
    print(state.title);
  }

  companySelect() {
    // emit(state.companyName.name);
  }
}
