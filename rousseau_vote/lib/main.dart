import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/providers/login.dart';

import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/login_screen.dart';
import 'package:rousseau_vote/src/screens/poll_details_screen.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/screens/register_screen.dart';

void main() => runApp(RousseauVoteApp());

class RousseauVoteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // TODO refactor using dependency injection (probably manually implemented)
        ChangeNotifierProvider(builder: (_) => Login(LoginNetworkHandler(Dio()))),
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