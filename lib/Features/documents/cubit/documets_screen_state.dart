part of 'documets_screen_cubit.dart';

class DocumetsScreenState extends Equatable {
  const DocumetsScreenState(
      {required this.dropdownMenuSelect,
      required this.documents,
      required this.allDocuments,
      required this.pageSelectc,
      required this.bills,
      required this.isLoading,
      required this.isEndOfList});
  final List<DocumentModel> bills;
  final bool isLoading;
  final bool isEndOfList;
  final PageSelect pageSelectc;
  final List<DocumentModel> documents;
  final List<DocumentModel> allDocuments;
  final String dropdownMenuSelect;

  factory DocumetsScreenState.initail() {
    return DocumetsScreenState(
      documents: const [],
      allDocuments: const [],
      bills: const [],
      isLoading: false,
      isEndOfList: false,
      pageSelectc: PageSelect.all,
      dropdownMenuSelect: dropDownList.first,
    );
  }
  DocumetsScreenState copyWith(
      {bills,
      isLoading,
      isEndOfList,
      pageSelectc,
      documents,
      allDocuments,
      dropdownMenuSelect}) {
    return DocumetsScreenState(
        documents: documents ?? this.documents,
        allDocuments: allDocuments ?? this.allDocuments,
        pageSelectc: pageSelectc ?? this.pageSelectc,
        bills: bills ?? this.bills,
        isLoading: isLoading ?? this.isLoading,
        isEndOfList: isEndOfList ?? this.isEndOfList,
        dropdownMenuSelect: dropdownMenuSelect ?? this.dropdownMenuSelect);
  }

  @override
  List<Object> get props => [
        bills,
        isLoading,
        isEndOfList,
        pageSelectc,
        documents,
        allDocuments,
        dropdownMenuSelect
      ];
}
