import 'dart:async';

import 'package:codeln_crime_map/add_crime_place_dialog.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CrimeMap extends StatefulWidget {
  @override
  _CrimeMapState createState() => _CrimeMapState();
}

class _CrimeMapState extends State<CrimeMap> {

  GoogleMapController mapController;
  bool _addCrimePlaceVisible = true;

  final LatLng _center = const LatLng(45.521563, -122.677433);


  void _openAddCrimePlaceDialog() async {
    String place = await Navigator.of(context).push(
      new PageRouteBuilder<String>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return AddCrimePlaceDialog();
        },
        fullscreenDialog: true
      )
    );

    BlocProvider.of<CrimeMapBloc>(context).add(SaveCrimePlace(place: place));

    // if (save != null) {

    // } else {

    // }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
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
          
          this._addCrimePlaceVisible = false;
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
              
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            floatingActionButton: Visibility(
              visible: fabAddCrimePlaceVisible,
              child: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CrimeMapBloc>(context).add(
                    CrimeMapAddButtonPressed()
                  );
                  this._openAddCrimePlaceDialog();
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