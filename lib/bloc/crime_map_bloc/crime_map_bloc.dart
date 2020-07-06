import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_event.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_state.dart';
import 'package:meta/meta.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';

class CrimeMapBloc extends Bloc<CrimeMapEvent, CrimeMapState> {

  final UserRepository _userRepository;

  CrimeMapBloc({@required UserRepository userRepository})
    : assert(userRepository != null),
      _userRepository = userRepository;

  @override
  CrimeMapState get initialState => CrimeMapInitial();

  @override
  Stream<CrimeMapState> mapEventToState(CrimeMapEvent event) async* {
    if (event is GettingCrimePlaces) {
      yield* _mapGettingCrimePlacesToState();
    } else if (event is CrimeMapAddButtonPressed) {
      yield* _mapCrimeMapAddButtonPressedToState();
    } else if (event is SaveCrimePlace) {
      yield* _mapSaveCrimePlaceToState(event.place);
    }
  }

  Stream<CrimeMapState> _mapGettingCrimePlacesToState() async* {
    // try {
    //   await _userRepository.signInWithGoogle();
    //   yield CrimeMapState.success();
    // } catch(_) {
    //   yield CrimeMapState.failure();
    // }
    var rand = new Random();
    if (rand.nextInt(100) % 2 == 0) {
      yield GettingPlacesSuccess([]);
    } else {
      yield GettingPlacesFailure();
    }
  }

  Stream<CrimeMapState> _mapCrimeMapAddButtonPressedToState() async* {
    // try {
    //   await _userRepository.signInWithGoogle();
    //   yield CrimeMapState.success();
    // } catch(_) {
    //   yield CrimeMapState.failure();
    // }
    yield AddingNewCrimePlace();
  }

  Stream<CrimeMapState> _mapSaveCrimePlaceToState(String place) async* {
    // try {
    //   await _userRepository.signInWithGoogle();
    //   yield CrimeMapState.success();
    // } catch(_) {
    //   yield CrimeMapState.failure();
    // }
    yield NewCrimePlaceAdded(place);
  }
  
}