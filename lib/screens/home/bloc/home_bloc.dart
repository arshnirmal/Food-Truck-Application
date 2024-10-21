import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_truck/controllers/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  HomeBloc(
    HomeRepository homeRepository,
  )   : _homeRepository = homeRepository,
        super(HomeInitial()) {
    on<UpdateCartCount>(_onUpdateCartCount);
  }

  void _onUpdateCartCount(UpdateCartCount event, Emitter<HomeState> emit) {
    emit(CartUpdated(cartCount: event.count));
  }
}
