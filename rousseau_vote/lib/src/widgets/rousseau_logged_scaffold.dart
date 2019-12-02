import 'package:flutter/material.dart';
import 'package:injectorio/injectorio.dart';

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
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    snap: false,
                    flexibleSpace: FlexibleSpaceBar(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Image(
                              image: const AssetImage('assets/images/rousseau_white.png'),
                              width: 200,
                          ),
                        ),
                        centerTitle: true,
                    ),
                  ),
                ];
              },
              body: Center(
                child: body,
              ),
            ),
          ),
        ));
  }
}
