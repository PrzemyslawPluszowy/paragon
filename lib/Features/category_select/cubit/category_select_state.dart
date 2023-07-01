part of 'category_select_cubit.dart';

class CategorySelectState extends Equatable {
  const CategorySelectState(
      {required this.selcetedCategory,
      required this.searchKeyWord,
      required this.searchCategories,
      required this.categories});
  final List<String> categories;
  final List<String> searchCategories;
  final String searchKeyWord;
  final String selcetedCategory;

  factory CategorySelectState.initial() {
    return CategorySelectState(
      selcetedCategory: '',
      searchKeyWord: '',
      searchCategories: const [],
      categories: companyList.map((e) => e['category']!).toSet().toList(),
    );
  }
  copyWith({searchKeyWord, searchCategories, categories, selcetedCategory}) {
    return CategorySelectState(
      selcetedCategory: selcetedCategory ?? this.selcetedCategory,
      searchKeyWord: searchKeyWord ?? this.searchKeyWord,
      searchCategories: searchCategories ?? this.searchCategories,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props =>
      [categories, searchCategories, searchKeyWord, selcetedCategory];
}
