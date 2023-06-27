part of 'homescreen_cubit.dart';

class AddRecipeState extends Equatable {
  const AddRecipeState(
      {required this.categoryList,
      required this.isLoading,
      required this.listItems,
      required this.listPrice,
      required this.date,
      required this.imagePath,
      required this.companyName});
  final bool isLoading;
  final String imagePath;
  final CompanyModel? companyName;
  final List<String> listItems;
  final List<String> listPrice;
  final DateTime date;
  final List<String> categoryList;

  factory AddRecipeState.initail() {
    return AddRecipeState(
        imagePath: '',
        companyName: null,
        listItems: const [],
        listPrice: const [],
        date: DateTime.now(),
        categoryList: const [],
        isLoading: false);
  }
  AddRecipeState copyWith(
      {List<String>? categoryList,
      bool? isLoading,
      String? imagePath,
      CompanyModel? companyName,
      List<String>? listItems,
      List<String>? listPrice,
      DateTime? date}) {
    return AddRecipeState(
        categoryList: categoryList ?? this.categoryList,
        isLoading: isLoading ?? this.isLoading,
        imagePath: imagePath ?? this.imagePath,
        companyName: companyName,
        listItems: listItems ?? this.listItems,
        listPrice: listPrice ?? this.listPrice,
        date: date ?? this.date);
  }

  @override
  List<Object?> get props => [
        imagePath,
        companyName,
        listItems,
        listPrice,
        date,
        categoryList,
        isLoading
      ];
}
