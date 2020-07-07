import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_event.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_state.dart';
import 'package:codeln_crime_map/models/models.dart';
import 'package:codeln_crime_map/repository/crime_places_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meta/meta.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';

class CrimeMapBloc extends Bloc<CrimeMapEvent, CrimeMapState> {

  final UserRepository _userRepository;
  final FirebaseCrimePlacesRepository _crimePlacesRepository;

  StreamSubscription _crimePlacesSubscription;

  CrimeMapBloc({@required UserRepository userRepository, @required FirebaseCrimePlacesRepository crimePlacesRepository})
    : assert(userRepository != null && crimePlacesRepository != null),
      _userRepository = userRepository,
      _crimePlacesRepository = crimePlacesRepository;

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
    } else if (event is CrimePlacesLoaded) {
      yield* _mapCrimePlacesLoadedToState(event.places);
    }
  }

  Stream<CrimeMapState> _mapGettingCrimePlacesToState() async* {
    print('\n[GETTING PLACES TO STATE] INIT \n');
    _crimePlacesSubscription?.cancel();

    _crimePlacesSubscription = _crimePlacesRepository.crimePlaces().listen(
      (places) => add(CrimePlacesLoaded(places: places))
    );
  }

  Stream<CrimeMapState> _mapCrimeMapAddButtonPressedToState() async* {
    yield CrimePlaceAddInProgress();
  }

  Stream<CrimeMapState> _mapSaveCrimePlaceToState(LatLng place) async* {
    yield CrimePlaceAddFinish();

    if (_crimePlacesRepository == null) {
      print('\nCRIME PLACES REPOSE IS NULL');
    }
    _crimePlacesRepository.saveCrimePlace(CrimePlace(place.latitude, place.longitude));
    // yield CrimePlaceAdded(place);
  }

  Stream<CrimeMapState> _mapCrimePlacesLoadedToState(List<CrimePlace> places) async* {
    print('\n[GETTING PLACES TO STATE] ${places.length} \n');
    yield CrimePlacesLoadSuccess(places);
  }
  
}