
import 'package:codeln_crime_map/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CrimeMapState extends Equatable {
  const CrimeMapState();

  @override
  List<Object> get props => [];
}

class CrimeMapInitial extends CrimeMapState {}

class CrimePlacesLoadInProgress extends CrimeMapState {}

class CrimePlacesLoadSuccess extends CrimeMapState {
  final List<String> places;

  const CrimePlacesLoadSuccess([this.places = const []]);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'CrimePlacesLoadSuccess { places: $places }';
}

class CrimePlacesLoadFailure extends CrimeMapState {}

class CrimePlaceAddInProgress extends CrimeMapState {}

class CrimePlaceAdded extends CrimeMapState {
  final String place;

  const CrimePlaceAdded(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'CrimePlaceAdded { Place : $place }';
}
