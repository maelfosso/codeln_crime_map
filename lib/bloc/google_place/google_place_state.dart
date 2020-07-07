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

class LoadGooglePlacesNearbyFailure extends GooglePlaceState {
  final String error;

  const LoadGooglePlacesNearbyFailure([this.error = ""]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoadGooglePlacesNearbyFailure { error: $error }';
}

class ReverseGeocodingInProgress extends GooglePlaceState {}

class ReverseGeocodingSuccess extends GooglePlaceState {
  final GooglePlace place;

  const ReverseGeocodingSuccess([this.place]);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'ReverseGeocodingSuccess { places: $place }';
}

class ReverseGeocodingFailure extends GooglePlaceState {
  final String error;

  const ReverseGeocodingFailure([this.error = ""]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ReverseGeocodingFailure { error: $error }';
}

