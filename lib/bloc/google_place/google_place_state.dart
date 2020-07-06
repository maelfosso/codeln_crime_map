import 'package:codeln_crime_map/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class GooglePlaceState extends Equatable {
  const GooglePlaceState();

  @override
  List<Object> get props => [];
}

class GooglePlaceInitial extends GooglePlaceState {}

class LoadGooglePlacesNearbySuccess extends GooglePlaceState {
  final List<GooglePlace> places;

  const LoadGooglePlacesNearbySuccess([this.places = const []]);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'LoadGooglePlacesNearbySuccess { places: $places }';
}

class LoadGooglePlacesNearbyFailure extends GooglePlaceState {}
