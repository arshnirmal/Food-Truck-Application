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
    on<FetchLocations>(_onFetchLocations);
    on<SelectLocation>(_onSelectLocation);
    on<UpdateCartCount>(_onUpdateCartCount);
  }

  void _onFetchLocations(FetchLocations event, Emitter<HomeState> emit) async {
    emit(const HomeLoading(isLoading: true));
    final locations = await _homeRepository.fetchLocations();
    final name = await _homeRepository.getUserName();

    if (locations.isNotEmpty) {
      emit(HomeLoaded(locations: locations, name: name));
    } else {
      emit(const HomeError(error: 'Failed to fetch locations'));
    }
    emit(const HomeLoading(isLoading: false));
  }

  void _onSelectLocation(SelectLocation event, Emitter<HomeState> emit) {
    emit(LocationSelected(selectedLocation: event.location));
  }

  void _onUpdateCartCount(UpdateCartCount event, Emitter<HomeState> emit) {
    emit(CartUpdated(cartCount: event.count));
  }
}
