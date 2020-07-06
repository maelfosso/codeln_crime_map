
import 'package:equatable/equatable.dart';

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
  String toString() => 'CrimePlacesLoadSuccess { todos: $places }';
}

class CrimePlacesLoadFailure extends CrimeMapState {}

class CrimePlaceAddInProgress extends CrimeMapState {}

class CrimePlaceAdded extends CrimeMapState {
  final CrimePlace place;

  const CrimePlaceAdded(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'CrimePlaceAdded { Place : $place }';
}

// class GettingPlacesSuccess extends CrimeMapState {
//   final List<String> places;

//   const GettingPlacesSuccess(this.places);

//   @override
//   List<Object> get props => [places];

//   @override
//   String toString() => 'GettingPlacesSuccess { Places : $places }';
// }

// class GettingPlacesFailure extends CrimeMapState {}