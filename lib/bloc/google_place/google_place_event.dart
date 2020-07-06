
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

abstract class GooglePlaceEvent extends Equatable {
  const GooglePlaceEvent();

  @override
  List<Object> get props => [];  
}

class LoadGooglePlacesNearby extends GooglePlaceEvent {
  final LatLng center;

  const LoadGooglePlacesNearby({
    @required this.center
  });

  @override
  List<Object> get props => [center];

  @override
  String toString() =>
      'LoadGooglePlacesNearby { place: $center }';
}
