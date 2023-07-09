import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rcp_new/Features/documents/data/bill_get_repo.dart';
import '../../../core/data/bill_model.dart';
import '../pages/documents_screen.dart';
part 'documets_screen_state.dart';

enum SortEnum {
  dateAddUp,
  dateAddDown,
  dateBuyUp,
  gwarancyDateUp,
  gwarancyDateDown,
  priceUp,
  priceDown,
  nameUp,
  nameDown,
}

class DocumetsScreenCubit extends Cubit<DocumetsScreenState> {
  DocumetsScreenCubit({required this.billGetRepo})
      : super(DocumetsScreenState.initail());

  final BillGetRepo billGetRepo;

  pageSelect({required PageSelect pageSelectc}) {
    emit(state.copyWith(pageSelectc: pageSelectc));
  }

  selectSort({SortEnum sort = SortEnum.dateAddUp}) {
    emit(state.copyWith(sort: sort));
    switch (sort) {
      case SortEnum.dateAddUp:
        emit(state.copyWith(querySort: 'dateCreated', isAscending: true));
        refreshDocument();
        break;
      case SortEnum.dateAddDown:
        emit(state.copyWith(querySort: 'dateCreated', isAscending: false));
        refreshDocument();
        break;
      case SortEnum.gwarancyDateDown:
        emit(state.copyWith(querySort: 'guaranteeDate', isAscending: true));
        refreshDocument();

        break;
      case SortEnum.gwarancyDateUp:
        emit(state.copyWith(querySort: 'guaranteeDate', isAscending: false));
        refreshDocument();

        break;
      case SortEnum.priceUp:
        emit(state.copyWith(querySort: 'price', isAscending: true));
        refreshDocument();

        break;
      case SortEnum.priceDown:
        emit(state.copyWith(querySort: 'price', isAscending: false));
        refreshDocument();

        break;
      case SortEnum.nameUp:
        emit(state.copyWith(querySort: 'name', isAscending: true));
        refreshDocument();

        break;
      case SortEnum.nameDown:
        emit(state.copyWith(querySort: 'guaranteeDate', isAscending: true));
        refreshDocument();

        break;

      default:
    }
  }

  deleteDocument({required String id}) async {
    emit(state.copyWith(isLoading: true));
    await billGetRepo.deleteBill(billId: id);

    emit(DocumetsScreenState.reloadList(
        querySort: state.querySort,
        isAscending: state.isAscending,
        sort: state.sort,
        pageSelectc: state.pageSelectc));
    billGetRepo.refreshDocument();
    emit(state.copyWith(isLoading: false));
  }

  refreshDocument() async {
    emit(DocumetsScreenState.reloadList(
        querySort: state.querySort,
        isAscending: state.isAscending,
        sort: state.sort,
        pageSelectc: state.pageSelectc));
    emit(state.copyWith(isLoading: true));
    billGetRepo.refreshDocument();
    loadBills();
  }

  loadBills() async {
    List<DocumentModel> bills = [];
    List<DocumentModel> withGwarancy = [];
    List<DocumentModel> withOutGwarancy = [];

    emit(state.copyWith(isLoading: true));
    final billsFetch = await billGetRepo.getBills(
      state.querySort,
      state.isAscending,
    );
    if (billsFetch.isEmpty) {
      emit(state.copyWith(isEndOfList: true, isLoading: false));
    }
    await Future.delayed(const Duration(milliseconds: 500));
    bills = [...state.bills, ...billsFetch];
    withGwarancy = bills.where((element) {
      return element.guaranteeDate != null;
    }).toList();

    withOutGwarancy =
        bills.where((element) => element.guaranteeDate == null).toList();
    emit(state.copyWith(
        bills: bills,
        withGwarancy: withGwarancy,
        isLoading: false,
        withOutGwarancy: withOutGwarancy));
  }
}
