import 'package:codeln_crime_map/bloc/google_place/bloc.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
          Widget widget = Container();

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
            widget = Container(
              padding: EdgeInsets.all(8.0),
              child: Text(state.error)
            );
          }

          
          return Center(
            child: Container(
              alignment: AlignmentDirectional(0.0, 0.0),
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                padding: EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    widget,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {},
                          child: new Text('Search on map',
                            style: Theme
                              .of(context)
                              .textTheme.subtitle1
                              // .subhead
                              .copyWith(color: Colors.white)
                            )
                        ),
                        RaisedButton.icon(
                          icon: Icon(Icons.my_location),
                          label: Text('Use my current location'),
                          color: Colors.white,
                          onPressed: () async {
                            Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                            Navigator
                              .of(context)
                              .pop(new LatLng(position.latitude, position.longitude));                            
                          },
                        )
                      ],
                    )
                  ],
                ),
                color: Colors.red,
              )
            )
          );
        },
      ),
      backgroundColor: Colors.transparent,
    );
  }
}