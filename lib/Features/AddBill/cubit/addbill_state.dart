part of 'addbill_cubit.dart';

class AddbillState extends Equatable {
  const AddbillState({
    required this.title,
    this.category,
    required this.categoryList,
    required this.isLoading,
    required this.listItems,
    required this.listPrice,
    required this.date,
    required this.imagePath,
    required this.companyName,
  });

  final bool isLoading;
  final String? imagePath;
  final String title;
  final String? category;
  final CompanyModel? companyName;
  final List<String>? listItems;
  final List<String>? listPrice;
  final DateTime? date;
  final List<String>? categoryList;

  factory AddbillState.initail() {
    return const AddbillState(
        imagePath: null,
        companyName: null,
        listItems: null,
        listPrice: null,
        date: null,
        categoryList: [],
        isLoading: false,
        title: '');
  }
  AddbillState copyWith(
      {List<String>? categoryList,
      bool? isLoading,
      String? imagePath,
      CompanyModel? companyName,
      List<String>? listItems,
      List<String>? listPrice,
      DateTime? date,
      String? title}) {
    return AddbillState(
        categoryList: categoryList ?? this.categoryList,
        isLoading: isLoading ?? this.isLoading,
        imagePath: imagePath,
        companyName: companyName,
        listItems: listItems,
        listPrice: listPrice,
        date: date,
        title: title ?? this.title);
  }

  @override
  List<Object?> get props => [
        imagePath,
        companyName,
        listItems,
        listPrice,
        date,
        categoryList,
        isLoading,
        title,
      ];
}
