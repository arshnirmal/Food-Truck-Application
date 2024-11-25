part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  final List<String> locations;
  final String? selectedLocation;
  final String error;
  final bool isLoading;

  const LocationState({
    this.locations = const [],
    this.selectedLocation,
    this.error = '',
    this.isLoading = false,
  });

  @override
  List<Object> get props => [locations, error, isLoading];
}

final class LocationInitial extends LocationState {
  const LocationInitial();
}

final class LocationLoaded extends LocationState {
  const LocationLoaded({
    required super.locations,
  });

  @override
  List<Object> get props => [locations];
}

final class LocationSelected extends LocationState {
  const LocationSelected({required super.selectedLocation});
}

final class LocationError extends LocationState {
  const LocationError({required super.error});

  @override
  List<Object> get props => [error];
}

final class LocationLoading extends LocationState {
  const LocationLoading({required super.isLoading});

  @override
  List<Object> get props => [isLoading];
}
