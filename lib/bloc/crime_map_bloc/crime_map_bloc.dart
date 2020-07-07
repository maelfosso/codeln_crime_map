import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_event.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_state.dart';
import 'package:codeln_crime_map/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
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
    if (event is LoadCrimePlaces) {
      yield* _mapGettingCrimePlacesToState();
    } else if (event is CrimeMapAddButtonPressed) {
      yield* _mapCrimeMapAddButtonPressedToState();
    } else if (event is SaveCrimePlace) {
      yield* _mapSaveCrimePlaceToState(event.place);
    }
  }

  Stream<CrimeMapState> _mapGettingCrimePlacesToState() async* {
    var rand = new Random();
    if (rand.nextInt(100) % 2 == 0) {
      yield CrimePlacesLoadSuccess([]);
    } else {
      yield CrimePlacesLoadFailure();
    }
  }

  Stream<CrimeMapState> _mapCrimeMapAddButtonPressedToState() async* {
    yield CrimePlaceAddInProgress();
  }

  Stream<CrimeMapState> _mapSaveCrimePlaceToState(LatLng place) async* {
    yield CrimePlaceAdded(place);
  }
  
}