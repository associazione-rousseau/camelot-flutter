import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

import 'package:rousseau_vote/src/widgets/drawer/rousseau_drawer.dart';

import 'logged_screen.dart';

// Widget to use for loggedin screens. It checks if the user is logged in. If
// not it redirects to the login screen. It also provide the default rousseau
// toolbar
class RousseauLoggedScaffold extends StatelessWidget {
  
  const RousseauLoggedScaffold({
    this.scaffoldKey,
    @required this.appBar, 
    @required this.body,
    this.floatingActionButton,
    this.showDrawer = true,
  });

  final Widget body;
  final Widget appBar;
  final bool showDrawer;
  final Widget floatingActionButton;
  final Key scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return LoggedScreen(
        Scaffold(
          appBar: appBar,
          key: scaffoldKey,
          drawer: showDrawer ? RousseauDrawer() : null,
          body: body,
          floatingActionButton: floatingActionButton,
          backgroundColor: BACKGROUND_GREY,
        ),
    );
  }
}
