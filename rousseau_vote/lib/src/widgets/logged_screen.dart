import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/screens/login_screen.dart';

// Widget to use for loggedin screens. It checks if the user is logged in. If
// not it redirects to the login screen.
class LoggedScreen extends StatelessWidget {

  const LoggedScreen(this.screen);

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    final Login loginContext = Provider.of<Login>(context);

    if (!loginContext.isLoggedIn()) {
      return LoginScreen();
    }

    return screen;
  }
}
