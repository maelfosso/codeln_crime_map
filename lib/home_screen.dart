import 'package:codeln_crime_map/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:codeln_crime_map/bloc/crime_map_bloc/bloc.dart';
import 'package:codeln_crime_map/crime_map_screen.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser currentUser;
  final UserRepository userRepository = UserRepository();

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
    // print(status);

    // You can can also directly ask the permission about its status.
    // if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      // print('[Permission.location.isRestricted] Is Restricted');
      // if (await Permission.location.request().isGranted) {
        // print('[Permission.location.isGranted] OK');
      // }
    // }

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
      body: BlocProvider(
        create: (context) => CrimeMapBloc(
          userRepository: userRepository
        )..add(GettingCrimePlaces()),
        child: CrimeMap(),
      )
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: <Widget>[
      //     Center(child: Text('Welcome ${currentUser.email}'))
      //   ],
      // )
    );
  }
}