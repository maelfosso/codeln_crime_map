import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CrimeMapEvent extends Equatable {
  const CrimeMapEvent();
  
  @override
  List<Object> get props => [];  
}

class GettingCrimePlaces extends CrimeMapEvent {}

class CrimeMapAddButtonPressed extends CrimeMapEvent {}

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