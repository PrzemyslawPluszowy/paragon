import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rcp_new/core/data/company_data.dart';

part 'category_select_state.dart';

class CategorySelectCubit extends Cubit<CategorySelectState> {
  CategorySelectCubit() : super(CategorySelectState.initial());

  sortList() {
    state.categories.sort();
  }

  searchCategory(String searchKeyWord) {
    emit(CategorySelectState.initial());
    sortList();
    emit(state.copyWith(
        searchKeyWord: searchKeyWord,
        categories: state.categories
            .where((element) =>
                element.toLowerCase().contains(searchKeyWord.toLowerCase()))
            .toList()));
  }

  setCategories(String category) {
    emit(state.copyWith(selcetedCategory: category));
  }
}
