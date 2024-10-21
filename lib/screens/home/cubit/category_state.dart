part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  final List<Category> categories;
  final int selectedCategory;
  final bool isLoading;
  final String error;

  const CategoryState({
    this.categories = const [],
    this.selectedCategory = 0,
    this.isLoading = false,
    this.error = '',
  });

  @override
  List<Object> get props => [categories, selectedCategory, isLoading, error];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  const CategoryLoaded({
    required super.categories,
  });

  @override
  List<Object> get props => [categories];
}

final class CategorySelected extends CategoryState {
  const CategorySelected({required super.selectedCategory});

  @override
  List<Object> get props => [selectedCategory];
}

final class CategoryLoading extends CategoryState {
  const CategoryLoading({required super.isLoading});

  @override
  List<Object> get props => [isLoading];
}

final class CategoryError extends CategoryState {
  const CategoryError({required super.error});

  @override
  List<Object> get props => [error];
}