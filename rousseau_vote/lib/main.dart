import 'package:flutter/material.dart';
import 'package:injectorio/injectorio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rousseau_vote/src/injection/dependency_injector.dart';
import 'package:rousseau_vote/src/providers/login.dart';

import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';
import 'package:rousseau_vote/src/screens/login_screen.dart';
import 'package:rousseau_vote/src/screens/poll_details_screen.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/screens/register_screen.dart';
import 'package:rousseau_vote/src/widgets/model/browser_arguments.dart';

void main() {
  DependencyInjector.initInjector();

  runApp(RousseauVoteApp());
}

class RousseauVoteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        // ignore: always_specify_types
        ChangeNotifierProvider(builder: (_) => get<Login>()),
      ],
      child: MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.red,
          primaryColor: const Color(0xFFE30613)
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
            final String pollId = ModalRoute.of(context).settings.arguments;
            return PollDetailsScreen(pollId);
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