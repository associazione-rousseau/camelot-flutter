import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/browser_arguments.dart';
import 'package:rousseau_vote/src/models/poll_detail_arguments.dart';
import 'package:rousseau_vote/src/providers/external_preselection.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';
import 'package:rousseau_vote/src/screens/login_screen.dart';
import 'package:rousseau_vote/src/screens/poll_details_screen.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/screens/register_screen.dart';

void main() {

  configure();

  runApp(RousseauVoteApp());
}

class RousseauVoteApp extends StatelessWidget {
  static const String CATEGORY = 'rousseau.widget.main';

  @override
  Widget build(BuildContext context) {
    developer.log('buildwidget', name: CATEGORY);

    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<Login>(builder: (_) => getIt<Login>()),
        ChangeNotifierProvider<ExternalPreselection>(builder: (_) => getIt<ExternalPreselection>()),
      ],
      child: MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.red,
          primaryColor: PRIMARY_RED
        ),
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          RousseauLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: <Locale>[
          const Locale('it'),
        ],
        routes: <String, WidgetBuilder>{
          PollsScreen.ROUTE_NAME: (BuildContext context) => PollsScreen(),
          LoginScreen.ROUTE_NAME: (BuildContext context) => LoginScreen(),
          RegisterScreen.ROUTE_NAME: (BuildContext context) => RegisterScreen(),
          PollDetailsScreen.ROUTE_NAME: (BuildContext context) {
            final PollDetailArguments arguments = ModalRoute.of(context).settings.arguments;
            return PollDetailsScreen(arguments);
          },
          InAppBrowser.ROUTE_NAME: (BuildContext context) {
            final BrowserArguments arguments = ModalRoute.of(context).settings.arguments;
            return InAppBrowser(arguments);
          },
        }
      ),
    );
  }
  
}