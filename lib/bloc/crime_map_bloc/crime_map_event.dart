import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

abstract class CrimeMapEvent extends Equatable {
  const CrimeMapEvent();

  @override
  List<Object> get props => [];  
}

class LoadCrimePlaces extends CrimeMapEvent {}

class SaveCrimePlace extends CrimeMapEvent {
  final String place;

  const SaveCrimePlace({
    @required this.place
  });

  @override
  List<Object> get props => [place];

  @override
  String toString() =>
      'SaveCrimePlace { place: $place }';

}

class CrimeMapAddButtonPressed extends CrimeMapEvent {}
