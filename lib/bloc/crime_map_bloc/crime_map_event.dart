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
  final LatLng place;

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
