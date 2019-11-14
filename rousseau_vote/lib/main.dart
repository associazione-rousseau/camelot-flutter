import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rousseau_vote/src/providers/login.dart';

import 'src/config/app_constants.dart';
import 'src/l10n/rousseau_localizations.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/poll_details_screen.dart';
import 'src/screens/polls_screen.dart';
import 'src/screens/register_screen.dart';

void main() => runApp(RousseauVoteApp());

class RousseauVoteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Login()),
      ],
      child: MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Color(0xFFE30613)
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
            String pollId = ModalRoute.of(context).settings.arguments as String;
            return PollDetailsScreen(pollId);
          },
        }
      ),
    );
  }
  
}