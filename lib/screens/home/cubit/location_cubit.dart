import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_truck/controllers/home_repository.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final HomeRepository _homeRepository;
  LocationCubit(
    HomeRepository homeRepository,
  )   : _homeRepository = homeRepository,
        super(LocationInitial());

  void fetchLocations() async {
    emit(const LocationLoading(isLoading: true));
    final locations = await _homeRepository.getLocations();
    if (locations.isNotEmpty) {
      emit(LocationLoaded(locations: locations));
    } else {
      emit(const LocationError(error: 'Failed to fetch locations'));
    }
    emit(const LocationLoading(isLoading: false));
  }

  void selectLocation(String location) {
    emit(LocationSelected(selectedLocation: location));
  }

  void clearSelectedLocation() {
    emit(const LocationSelected(selectedLocation: ''));
  }
}
