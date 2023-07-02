part of 'documets_screen_cubit.dart';

class DocumetsScreenState extends Equatable {
  const DocumetsScreenState(
      {required this.documents,
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

  factory DocumetsScreenState.initail() {
    return const DocumetsScreenState(
      documents: [],
      allDocuments: [],
      bills: [],
      isLoading: false,
      isEndOfList: false,
      pageSelectc: PageSelect.all,
    );
  }
  DocumetsScreenState copyWith(
      {bills, isLoading, isEndOfList, pageSelectc, documents, allDocuments}) {
    return DocumetsScreenState(
      documents: documents ?? this.documents,
      allDocuments: allDocuments ?? this.allDocuments,
      pageSelectc: pageSelectc ?? this.pageSelectc,
      bills: bills ?? this.bills,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
    );
  }

  @override
  List<Object> get props =>
      [bills, isLoading, isEndOfList, pageSelectc, documents, allDocuments];
}
