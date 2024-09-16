part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchLocations extends HomeEvent {}

class SelectLocation extends HomeEvent {
  final String location;

  const SelectLocation(this.location);

  @override
  List<Object> get props => [location];
}

class UpdateCartCount extends HomeEvent {
  final int count;

  const UpdateCartCount(this.count);

  @override
  List<Object> get props => [count];
}