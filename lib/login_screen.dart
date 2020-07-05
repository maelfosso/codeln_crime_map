import 'package:codeln_crime_map/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:codeln_crime_map/bloc/login_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
    : assert(userRepository != null),
      _userRepository = userRepository,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Login Failure'),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Colors.red,
                )
              );
          }

          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedIn());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Center(
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(
                    LoginWithGooglePressed()
                  );
                }, 
                icon: Icon(FontAwesomeIcons.google, color: Colors.white), 
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                color: Colors.redAccent,
              ),
            );
          },
        ),
      )
      // BlocProvider<LoginBloc>(
      //   create: (context) => LoginBloc(userRepository: _userRepository),
      //   child: Container()
      // )
    );
  }
}