import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/screens/activists_screen.dart';

class RousseauSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: PRIMARY_RED,),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ActivistsScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(query);
  }

}