import 'package:flutter/material.dart';
import 'package:injectorio/injectorio.dart';

import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/init/startup_initializer.dart';
import 'package:rousseau_vote/src/widgets/wait_for_init_widget.dart';

import 'logged_screen.dart';

// Widget to use for loggedin screens. It checks if the user is logged in. If
// not it redirects to the login screen. It also provide the default rousseau
// toolbar
class RousseauLoggedScaffold extends StatelessWidget {

  const RousseauLoggedScaffold(this.body);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return WaitForStartupInitWidget(
      startupInitializer: get<StartupInitializer>(),
      showAfterInit: LoggedScreen(
          Scaffold(
            appBar: AppBar(title: Text(TOOLBAR_TITLE)),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  body
                ],
              ),
            ),
          )
      ),
    );
  }
}
