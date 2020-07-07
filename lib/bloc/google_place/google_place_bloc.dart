import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_state.dart';
import 'package:codeln_crime_map/bloc/google_place/bloc.dart';
import 'package:codeln_crime_map/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

const API_KEY = "AIzaSyAk0tS2LhxhnDF8gjVzZKczuet_NF7k3RM";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: API_KEY);
GoogleMapsGeocoding geocoding = new GoogleMapsGeocoding(apiKey: API_KEY);

class GooglePlaceBloc extends Bloc<GooglePlaceEvent, GooglePlaceState> {

  // final UserRepository _userRepository;

  GooglePlaceBloc();

  @override
  GooglePlaceState get initialState => GooglePlaceInitial();

  @override
  Stream<GooglePlaceState> mapEventToState(GooglePlaceEvent event) async* {
    if (event is LoadGooglePlacesNearby) {
      yield* _mapLoadGooglePlacesNearbyToState(event.center);
    } else if (event is ReverseGeocoding) {
      yield* _mapReverseGeocodingToState(event.latLng);
    }
  }

  Stream<GooglePlaceState> _mapLoadGooglePlacesNearbyToState(LatLng latLng) async* {
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

  Stream<GooglePlaceState> _mapReverseGeocodingToState(LatLng latLng) async* {
    try {
      yield ReverseGeocodingInProgress();
      // var results = await Geocoder.google(API_KEY).findAddressesFromCoordinates(new Coordinates(latLng.latitude, latLng.longitude));
      List<Placemark> results = await Geolocator().placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      // GeocodingResponse response = await geocoding.searchByLocation(Location(latLng.latitude, latLng.longitude));
      // print(response.errorMessage);
      // print(response.status);
      // final results = response.results;
      print(results);

      if (results.isEmpty || results.length == 0) {
        yield ReverseGeocodingFailure("No Address FOUND !");
      } else {
        final first = results.first;
        // print(first.toMap());
        // yield ReverseGeocodingSuccess(GooglePlace('', '${first.featureName}\t${first.addressLine}', latLng.latitude, latLng.longitude));

        print(first.toJson());
        yield ReverseGeocodingSuccess(GooglePlace(
          '', 
          '${first.name}___${first.locality}, ${first.postalCode}, ${first.administrativeArea}, ${first.country}', 
          first.position.latitude, first.position.longitude
        ));
        // print(first.addressComponents);
        // yield ReverseGeocodingSuccess(GooglePlace(first.placeId, first.formattedAddress, latLng.latitude, latLng.longitude));
      }
    } on Exception catch (error, stack) {
      print(error);
      print(stack);
      yield ReverseGeocodingFailure("An error occurred. Please, try another location.");
    }
  }
  
}