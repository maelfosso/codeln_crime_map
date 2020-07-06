import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_state.dart';
import 'package:codeln_crime_map/bloc/google_place/bloc.dart';
import 'package:codeln_crime_map/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyAk0tS2LhxhnDF8gjVzZKczuet_NF7k3RM");

class GooglePlaceBloc extends Bloc<GooglePlaceEvent, GooglePlaceState> {

  // final UserRepository _userRepository;

  GooglePlaceBloc();

  @override
  GooglePlaceState get initialState => GooglePlaceInitial();

  @override
  Stream<GooglePlaceState> mapEventToState(GooglePlaceEvent event) async* {
    if (event is LoadGooglePlacesNearby) {
      yield* _mapLoatGooglePlacesNearbyToState(event.center);
    }
  }

  Stream<GooglePlaceState> _mapLoatGooglePlacesNearbyToState(LatLng latLng) async* {
    Location location = Location(latLng.latitude, latLng.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    List<GooglePlace> crimePlaces = [];
    print('\nPLACES.... ${_places.apiKey}');

    if (result.status == "OK") {
      for (int i = 0; i < result.results.length; i++) {
        final f = result.results[i];
        crimePlaces.add(GooglePlace(f.id, f.name, f.geometry.location.lat, f.geometry.location.lng));
      }
      
      yield LoadGooglePlacesNearbySuccess(crimePlaces);
    } else {
      print(result.status);
      print(result.errorMessage);
      
      yield LoadGooglePlacesNearbyFailure(result.errorMessage);
    }
  }
  
}