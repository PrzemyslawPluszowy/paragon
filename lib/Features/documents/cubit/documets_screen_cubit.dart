import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rcp_new/Features/documents/bill_get_repo.dart';

import '../../../core/data/bill_model.dart';
import '../pages/documents_screen.dart';

part 'documets_screen_state.dart';

class DocumetsScreenCubit extends Cubit<DocumetsScreenState> {
  DocumetsScreenCubit({required this.billGetRepo})
      : super(DocumetsScreenState.initail());

  final BillGetRepo billGetRepo;

  pageSelect({required PageSelect pageSelectc}) {
    emit(state.copyWith(pageSelectc: pageSelectc));
  }

  loadBills() async {
    List<BillModel> bills = [];

    emit(state.copyWith(isLoading: true));
    final billsFetch = await billGetRepo.getBills();
    if (billsFetch.isEmpty) {
      emit(state.copyWith(isEndOfList: true, isLoading: false));
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    bills = [...state.bills, ...billsFetch];
    emit(state.copyWith(bills: bills, isLoading: false));
  }
}
