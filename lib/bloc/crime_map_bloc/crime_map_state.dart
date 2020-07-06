
import 'package:equatable/equatable.dart';

abstract class CrimeMapState extends Equatable {
  const CrimeMapState();

  @override
  List<Object> get props => [];
}

class CrimeMapInitial extends CrimeMapState {}

class GettingPlacesSuccess extends CrimeMapState {
  final List<String> places;

  const GettingPlacesSuccess(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'GettingPlacesSuccess { Places : $places }';
}

class GettingPlacesFailure extends CrimeMapState {}

class AddingNewCrimePlace extends CrimeMapState {}
