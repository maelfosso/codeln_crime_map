import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_bloc.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/crime_map_event.dart';
import 'package:codeln_crime_map/bloc/google_place/bloc.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddCrimePlaceDialog extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final LatLng center;

  AddCrimePlaceDialog({Key key, @required LatLng latLng})
    : this.center = latLng,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New crime'),
        actions: [
          new FlatButton(
            onPressed: () {
              //TODO: Handle save
            },
            child: new Text('SAVE',
              style: Theme
                .of(context)
                .textTheme.subtitle1
                // .subhead
                .copyWith(color: Colors.white)
              )
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<GooglePlaceBloc, GooglePlaceState>(
        builder: (context, state) {
          Widget widget;

          if (state is LoadGooglePlacesNearbySuccess) {
            widget = ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: state.places.length,
              itemBuilder: (BuildContext context, int index) {
                final place = state.places[index];

                return ListTile(
                  title: Text(place.name)
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider()
            ); 
          }
          if (state is LoadGooglePlacesNearbyFailure) {
            widget = Text("Loading places failed");
          }

          // return Center(
          //   child: Container(
          //     color: Color.fromARGB(255, 66, 165, 245),
          //     child: new Text("Flutter Cheatsheet",
          //       style: TextStyle(
          //         fontSize: 10.0
          //       ),
          //     ),
          //     alignment: Alignment(0.0, 0.0),
          //   ),
          // );
          return Container( 
            // padding: const EdgeInsets.all(16.0),
            // color: Colors.transparent,
            // width: ,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    widget,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            //TODO: Handle save
                          },
                          child: new Text('Search on map',
                            style: Theme
                              .of(context)
                              .textTheme.subtitle1
                              // .subhead
                              .copyWith(color: Colors.white)
                            )
                        ),
                        IconButton(
                          icon: Icon(Icons.my_location),
                          tooltip: 'Use my current location',
                          onPressed: () {
                            
                          },
                        ),
                        // new FlatButton(
                        //   onPressed: () {
                        //     //TODO: Handle save
                        //   },
                        //   child: new Text('Search on map',
                        //     style: Theme
                        //       .of(context)
                        //       .textTheme.subtitle1
                        //       // .subhead
                        //       .copyWith(color: Colors.white)
                        //     )
                        // ),
                      ],
                    )
                  ],
                ),
                alignment: Alignment(0.0, 0.0),
              )
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
    );
  }
}