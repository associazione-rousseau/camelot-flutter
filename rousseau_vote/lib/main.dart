import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/login.dart';

import 'src/l10n/rousseau_localizations.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/poll_details_screen.dart';
import 'src/screens/polls_screen.dart';
import 'src/screens/register_screen.dart';

void main() => runApp(RousseauVoteApp());

class RousseauVoteApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Login()),
      ],
      //builder: (context) => Login(),
      child: MaterialApp(
          title: 'Rousseau vote',
          theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: Color(0xFFD11F25)
          ),
          localizationsDelegates: [
            RousseauLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('it'),
          ],
          routes: {
            PollsScreen.routeName: (context) => PollsScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            PollDetailsScreen.routeName: (context) {
              String pollId =
                  ModalRoute.of(context).settings.arguments as String;
              return PollDetailsScreen(pollId);
            },
          }),
    );
  }
}
