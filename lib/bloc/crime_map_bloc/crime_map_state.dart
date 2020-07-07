
import 'package:codeln_crime_map/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CrimeMapState extends Equatable {
  const CrimeMapState();

  @override
  List<Object> get props => [];
}

class CrimeMapInitial extends CrimeMapState {}

class CrimePlacesLoadInProgress extends CrimeMapState {}

class CrimePlacesLoadSuccess extends CrimeMapState {
  final List<CrimePlace> places;

  const CrimePlacesLoadSuccess([this.places = const []]);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'CrimePlacesLoadSuccess { places: $places }';
}

class CrimePlacesLoadFailure extends CrimeMapState {}

class CrimePlaceAddInProgress extends CrimeMapState {}

class CrimePlaceAddFinish extends CrimeMapState {}

class CrimePlaceAdded extends CrimeMapState {
  final LatLng place;

  const CrimePlaceAdded(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'CrimePlaceAdded { Place : $place }';
}
