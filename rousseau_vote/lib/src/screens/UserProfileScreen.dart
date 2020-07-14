
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class UserProfileScreen extends StatelessWidget {

  const UserProfileScreen(this._arguments);

  static const String ROUTE_NAME = '/user_profile';

  final UserProfileArguments _arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RousseauAppBar(),
      body: Text(_arguments.slug),
    );
  }

}

class UserProfileArguments {

  UserProfileArguments(this.slug);

  final String slug;
}
