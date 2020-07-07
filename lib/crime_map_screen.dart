import 'dart:async';

import 'package:codeln_crime_map/add_crime_place_dialog.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/bloc.dart';
import 'package:codeln_crime_map/bloc/google_place/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CrimeMap extends StatefulWidget {
  @override
  _CrimeMapState createState() => _CrimeMapState();
}

class _CrimeMapState extends State<CrimeMap> {

  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  CameraPosition _cameraPosition;

  void _openAddCrimePlaceDialogFromMap(LatLng latLng) async {
    LatLng place = await Navigator.of(context).push(
      new PageRouteBuilder<LatLng>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return // AddCrimePlaceDialog(latLng: _cameraPosition.target);
          BlocProvider(
            create: (context) => GooglePlaceBloc()
              ..add(ReverseGeocoding(latLng: latLng)),
            child: AddCrimePlaceDialog(latLng: _cameraPosition.target)
          ); 
        },
        fullscreenDialog: true
      )
    );

    print('[openAddCrimePlaceDialogFromMAP] $place');
    if (place != null) {
      BlocProvider.of<CrimeMapBloc>(context).add(SaveCrimePlace(place: place));
    }    
  }

  void _openAddCrimePlaceDialogFromFAB() async {
    LatLng place = await Navigator.of(context).push(
      new PageRouteBuilder<LatLng>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return BlocProvider(
            create: (context) => GooglePlaceBloc()
              ..add(LoadGooglePlacesNearby(center: _cameraPosition.target)),
            child: AddCrimePlaceDialog(latLng: _cameraPosition.target)
          ); 
        },
        fullscreenDialog: true
      )
    );

    print('[openAddCrimePlaceDialogFromFAB] $place');
    BlocProvider.of<CrimeMapBloc>(context).add(SaveCrimePlace(place: place));
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    print('[onCameraMove] $position');
    _cameraPosition = position;
  }

  @override
  Widget build(BuildContext context) {
    _cameraPosition = CameraPosition(target: _center);

    return BlocListener<CrimeMapBloc, CrimeMapState>(
      listener: (context, state) {
        if (state is CrimePlacesLoadSuccess) {
          List<String> places = state.places;

          // Display the places as markers
          print('\n[BlocListener - CrimeMapBloc] State - GettingPlacesSuccess');
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Crime places successfully displayed'),
                    Icon(Icons.thumb_up)
                  ],
                )
              )
            );
        }
        if (state is CrimePlacesLoadFailure) {
          // Show the snackbar
          print('\n[BlocListener - CrimeMapBloc] State - GettingPlacesFailure');
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Getting crime places failed'),
                    Icon(Icons.error)
                  ],
                ),
                action: SnackBarAction(
                  label: 'Refresh',
                  onPressed: () {
                    // Some code to undo the change.
                    BlocProvider.of<CrimeMapBloc>(context).add(LoadCrimePlaces());
                  },
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 365*1000),
              )
            );
        }
        if (state is CrimePlaceAddInProgress) {
          // 1. Remove all the markers from the map
          // 2. Show the transparent screen for adding crime places
          print('\n[BlocListener - CrimeMapBloc] State - AddingNewCrimePlace');
        }
      },
      child: BlocBuilder<CrimeMapBloc, CrimeMapState>(
        builder: (context, state) {
          bool fabAddCrimePlaceVisible = true;

          if (state is CrimePlaceAddInProgress) {
            fabAddCrimePlaceVisible = false;
          }
          if (state is CrimePlaceAdded) {
            fabAddCrimePlaceVisible = true;
          }

          return new Scaffold(
            body:  GoogleMap(
              onMapCreated: _onMapCreated,
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              onCameraMove: _onCameraMove,
              onTap: (LatLng latLng) {
                this._openAddCrimePlaceDialogFromMap(latLng);
              },
              
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 18.0,
              ),
            ),
            floatingActionButton: Visibility(
              visible: fabAddCrimePlaceVisible,
              child: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CrimeMapBloc>(context).add(
                    CrimeMapAddButtonPressed()
                  );
                  this._openAddCrimePlaceDialogFromFAB();
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.red,
              ),
            )
          );
        }     
      )
    );
  }
}