import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcp_new/Features/bil_screen/data/bill_repo.dart';
import 'package:rcp_new/core/data/bill_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit({required this.billRepo}) : super(BillState.initail());

  final BillRepo billRepo;

  saveBill(DocumentModel bill) async {
    emit(state.copyWith(isLoading: true));
    try {
      await billRepo.saveBill(bill: bill);
      emit(state.copyWith(isLoading: false));
      Fluttertoast.showToast(msg: 'Zapisałem paragon');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
