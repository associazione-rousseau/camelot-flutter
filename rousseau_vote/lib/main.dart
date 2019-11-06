import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/login.dart';

import 'src/screens/login_screen.dart';
import 'src/screens/poll_details_screen.dart';
import 'src/screens/polls_screen.dart';
import 'src/screens/register_screen.dart';

void main() => runApp(RousseauVoteApp());

class RousseauVoteApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Login>(
        builder: (context) => Login(),
        dispose: (context, value) => value.dispose(),
        child: MaterialApp(
            title: 'Rousseau Vote',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            routes: {
              '/': (context) => PollsScreen(),
              '/login': (context) => LoginScreen(),
              '/register': (context) => RegisterScreen(),
              '/polls': (context) {
                String pollId =
                ModalRoute
                    .of(context)
                    .settings
                    .arguments as String;
                return PollDetailsScreen(pollId);
              },
            }
           )
    );
  }
}
