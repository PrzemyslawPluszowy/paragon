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
  final String? imagePath;
  final CompanyModel? companyName;
  final List<String>? listItems;
  final List<String>? listPrice;
  final DateTime? date;
  final List<String>? categoryList;

  factory AddRecipeState.initail() {
    return const AddRecipeState(
        imagePath: null,
        companyName: null,
        listItems: null,
        listPrice: null,
        date: null,
        categoryList: [],
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
        imagePath: imagePath,
        companyName: companyName,
        listItems: listItems,
        listPrice: listPrice,
        date: date);
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

class AddRecipeLoaded extends AddRecipeState {
  const AddRecipeLoaded(
      {required List<String>? categoryList,
      required bool isLoading,
      required List<String>? listItems,
      required List<String>? listPrice,
      required DateTime? date,
      required String? imagePath,
      required CompanyModel? companyName})
      : super(
            categoryList: categoryList,
            isLoading: isLoading,
            listItems: listItems,
            listPrice: listPrice,
            date: date,
            imagePath: imagePath,
            companyName: companyName);
}
