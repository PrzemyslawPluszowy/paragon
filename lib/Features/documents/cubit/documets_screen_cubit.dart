import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rcp_new/Features/documents/data/bill_get_repo.dart';
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

  deleteDocument({required String id}) async {
    emit(state.copyWith(isLoading: true));
    await billGetRepo.deleteBill(billId: id);
    emit(DocumetsScreenState.initail());
    billGetRepo.refreshDocument();
    await loadBills();
  }

  refreshDocument() async {
    emit(DocumetsScreenState.initail());
    emit(state.copyWith(isLoading: true));
    billGetRepo.refreshDocument();
    loadBills();
  }

  loadBills() async {
    List<DocumentModel> bills = [];
    List<DocumentModel> allDocuments = [];
    List<DocumentModel> documents = [];

    emit(state.copyWith(isLoading: true));
    final billsFetch = await billGetRepo.getBills();
    if (billsFetch.isEmpty) {
      emit(state.copyWith(isEndOfList: true, isLoading: false));
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    bills = [...state.bills, ...billsFetch];
    allDocuments = [...state.allDocuments, ...bills];

    emit(state.copyWith(
        bills: bills,
        allDocuments: allDocuments,
        isLoading: false,
        documents: documents));
  }
}
