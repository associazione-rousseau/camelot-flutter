import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

import 'package:rousseau_vote/src/widgets/drawer/rousseau_drawer.dart';

import 'logged_screen.dart';

// Widget to use for loggedin screens. It checks if the user is logged in. If
// not it redirects to the login screen. It also provide the default rousseau
// toolbar
class RousseauLoggedScaffold extends StatelessWidget {
  
  const RousseauLoggedScaffold({
    @required this.appBar, 
    @required this.body
  });

  final Widget body;
  final Widget appBar;

  @override
  Widget build(BuildContext context) {
    return LoggedScreen(
        Scaffold(
          appBar: appBar,
          drawer: RousseauDrawer(),
          body: body,
          backgroundColor: BACKGROUND_GREY,
        ),
    );
  }
}
