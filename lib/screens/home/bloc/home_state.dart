part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final List<String> locations;
  final String selectedLocation;
  final bool isLoading;
  final String error;
  final int cartCount;
  final String name;

  const HomeState({
    this.locations = const [],
    this.selectedLocation = '',
    this.isLoading = false,
    this.error = '',
    this.cartCount = 0,
    this.name = '',
  });

  @override
  List<Object> get props => [locations, isLoading, error, selectedLocation, cartCount, name];
}

final class HomeInitial extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required super.locations, required super.name});

  @override
  List<Object> get props => [locations, name];
}

final class LocationSelected extends HomeState {
  const LocationSelected({required super.selectedLocation});

  @override
  List<Object> get props => [selectedLocation];
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
