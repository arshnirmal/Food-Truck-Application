part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UpdateCartCount extends HomeEvent {
  final int count;

  const UpdateCartCount(this.count);

  @override
  List<Object> get props => [count];
}
