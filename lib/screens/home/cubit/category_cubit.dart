import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_truck/controllers/home_repository.dart';
import 'package:food_truck/models/food_items/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeRepository _homeRepository;
  CategoryCubit(
    HomeRepository homeRepository,
  )   : _homeRepository = homeRepository,
        super(CategoryInitial());

  void selectCategory(int categoryId) {
    emit(CategorySelected(selectedCategory: categoryId));
  }

  void fetchCategories() async {
    emit(const CategoryLoading(isLoading: true));
    final categories = await _homeRepository.getCategories();
    if (categories.isNotEmpty) {
      emit(CategoryLoaded(categories: categories));
    } else {
      emit(const CategoryError(error: 'Failed to fetch categories'));
    }
    emit(const CategoryLoading(isLoading: false));
  }
}
