import 'package:codeln_crime_map/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCrimePlaceDialog extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  AddCrimePlaceDialog({Key key})
    : super(key: key);

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
      body: new Text("Foo"),
      backgroundColor: Colors.transparent,
    );
  }
}