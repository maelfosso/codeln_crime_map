import 'package:codeln_crime_map/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/bloc.dart';
import 'package:codeln_crime_map/bloc/google_place/bloc.dart';
import 'package:codeln_crime_map/crime_map_screen.dart';
import 'package:codeln_crime_map/repository/crime_places_repository.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser currentUser;
  final UserRepository userRepository = UserRepository();
  final FirebaseCrimePlacesRepository crimePlacesRepository = FirebaseCrimePlacesRepository();

  HomeScreen({Key key, @required this.currentUser})
    : super(key: key);

  void _checkPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // We didn't ask for permission yet.
      print('[Permission.location.status] Is Not Granted');
      if (await Permission.location.request().isGranted) {
        print('[Permission.location.isGranted] OK');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkPermission();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLoggedOut());
            },
          )
        ]
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CrimeMapBloc(
              userRepository: userRepository,
              crimePlacesRepository: crimePlacesRepository
            )..add(LoadCrimePlaces()),
          ),
          BlocProvider(
            create: (context) => GooglePlaceBloc()
          )
        ],
        child: CrimeMap() // CrimeMapApp(userRepository: userRepository),
      ) 
      // BlocProvider(
      //   create: (context) => CrimeMapBloc(
      //     userRepository: userRepository
      //   )..add(LoadCrimePlaces()), // CrimePlacesLoaded()
      //   child: CrimeMap(),
      // )
    );
  }
}