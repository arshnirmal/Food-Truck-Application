part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  final List<String> locations;
  final String selectedLocation;
  final String error;
  final bool isLoading;

  const LocationState({
    this.locations = const [],
    this.selectedLocation = '',
    this.error = '',
    this.isLoading = false,
  });

  @override
  List<Object> get props => [locations, selectedLocation, error, isLoading];
}

final class LocationInitial extends LocationState {}

final class LocationLoaded extends LocationState {
  const LocationLoaded({
    required super.locations,
  });

  @override
  List<Object> get props => [locations];
}

final class LocationSelected extends LocationState {
  const LocationSelected({required super.selectedLocation});

  @override
  List<Object> get props => [selectedLocation];
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