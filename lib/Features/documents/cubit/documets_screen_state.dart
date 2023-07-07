part of 'documets_screen_cubit.dart';

class DocumetsScreenState extends Equatable {
  const DocumetsScreenState(
      {required this.sort,
      required this.querySort,
      required this.isAscending,
      required this.withOutGwarancy,
      required this.withGwarancy,
      required this.pageSelectc,
      required this.bills,
      required this.isLoading,
      required this.isEndOfList});
  final List<DocumentModel> bills;
  final bool isLoading;
  final bool isEndOfList;
  final PageSelect pageSelectc;
  final List<DocumentModel> withOutGwarancy;
  final List<DocumentModel> withGwarancy;
  final SortEnum sort;
  final String querySort;
  final bool isAscending;

  factory DocumetsScreenState.initail() {
    return const DocumetsScreenState(
      withOutGwarancy: [],
      withGwarancy: [],
      bills: [],
      isLoading: false,
      isEndOfList: false,
      pageSelectc: PageSelect.all,
      sort: SortEnum.dateAddUp,
      querySort: 'dateCreated',
      isAscending: true,
    );
  }
  factory DocumetsScreenState.reloadList({
    required String querySort,
    required bool isAscending,
    required SortEnum sort,
    required PageSelect pageSelectc,
  }) {
    return DocumetsScreenState(
      withOutGwarancy: const [],
      withGwarancy: const [],
      bills: const [],
      isLoading: true,
      isEndOfList: false,
      pageSelectc: pageSelectc,
      sort: sort,
      querySort: querySort,
      isAscending: isAscending,
    );
  }

  DocumetsScreenState copyWith(
      {bills,
      querySort,
      isAscending,
      withGwarancy,
      sort,
      isLoading,
      isEndOfList,
      pageSelectc,
      withOutGwarancy,
      dropdownMenuSelect}) {
    return DocumetsScreenState(
      querySort: querySort ?? this.querySort,
      isAscending: isAscending ?? this.isAscending,
      withOutGwarancy: withOutGwarancy ?? this.withOutGwarancy,
      withGwarancy: withGwarancy ?? this.withGwarancy,
      pageSelectc: pageSelectc ?? this.pageSelectc,
      bills: bills ?? this.bills,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object> get props => [
        querySort,
        isAscending,
        sort,
        bills,
        isLoading,
        isEndOfList,
        pageSelectc,
        withOutGwarancy,
        withGwarancy,
      ];
}
