part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final bool isLoading;
  final String error;
  final int cartCount;
  final String name;

  const HomeState({
    this.isLoading = false,
    this.error = '',
    this.cartCount = 0,
    this.name = '',
  });

  @override
  List<Object> get props => [isLoading, error, cartCount, name];
}

final class HomeInitial extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required super.name});

  @override
  List<Object> get props => [name];
}

final class HomeError extends HomeState {
  const HomeError({required super.error});

  @override
  List<Object> get props => [error];
}

final class HomeLoading extends HomeState {
  const HomeLoading({required super.isLoading});

  @override
  List<Object> get props => [isLoading];
}

final class CartUpdated extends HomeState {
  const CartUpdated({required super.cartCount});

  @override
  List<Object> get props => [cartCount];
}
