part of 'documets_screen_cubit.dart';

class DocumetsScreenState extends Equatable {
  const DocumetsScreenState(
      {required this.pageSelectc,
      required this.bills,
      required this.isLoading,
      required this.isEndOfList});
  final List<BillModel> bills;
  final bool isLoading;
  final bool isEndOfList;
  final PageSelect pageSelectc;

  factory DocumetsScreenState.initail() {
    return const DocumetsScreenState(
      bills: [],
      isLoading: false,
      isEndOfList: false,
      pageSelectc: PageSelect.all,
    );
  }
  DocumetsScreenState copyWith({bills, isLoading, isEndOfList, pageSelectc}) {
    return DocumetsScreenState(
      pageSelectc: pageSelectc ?? this.pageSelectc,
      bills: bills ?? this.bills,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
    );
  }

  @override
  List<Object> get props => [bills, isLoading, isEndOfList, pageSelectc];
}
