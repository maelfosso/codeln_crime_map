import 'package:equatable/equatable.dart';

abstract class CrimeMapEvent extends Equatable {
  @override
  List<Object> get props => [];  
}

class GettingCrimePlaces extends CrimeMapEvent {}

class CrimeMapAddButtonPressed extends CrimeMapEvent {}
