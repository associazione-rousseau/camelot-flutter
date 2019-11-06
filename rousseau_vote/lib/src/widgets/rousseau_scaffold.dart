

import 'package:flutter/material.dart';
import '../config/app_constants.dart' as AppConstants;

class RousseauLoggedScaffold extends Scaffold {

  RousseauLoggedScaffold({Key key, Widget body}) : super(
    key: key,
    appBar: AppBar(
      title: Text(AppConstants.TOOLBAR_TITLE),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          body
        ],
      ),
    ),
  );
}