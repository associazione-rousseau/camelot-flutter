import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rousseau_vote/src/error_reporting/error_logger.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/arguments/blog_instant_article_arguments.dart';
import 'package:rousseau_vote/src/models/browser_arguments.dart';
import 'package:rousseau_vote/src/models/poll_detail_arguments.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/providers/blog_instant_article_provider.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/providers/external_preselection.dart';
import 'package:rousseau_vote/src/screens/account/contact_preferences_screen.dart';
import 'package:rousseau_vote/src/screens/account/delete_account_disclaimer_screen.dart';
import 'package:rousseau_vote/src/screens/account/delete_account_action_screen.dart';
import 'package:rousseau_vote/src/screens/account/login_info_screen.dart';
import 'package:rousseau_vote/src/screens/account/residence_screen.dart';
import 'package:rousseau_vote/src/screens/feedback_screen.dart';
import 'package:rousseau_vote/src/screens/success_screen.dart';
import 'package:rousseau_vote/src/screens/user_profile_screen.dart';
import 'package:rousseau_vote/src/screens/blog_instant_article_screen.dart';
import 'package:rousseau_vote/src/screens/blog_screen.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';
import 'package:rousseau_vote/src/screens/init_screen.dart';
import 'package:rousseau_vote/src/screens/login_screen.dart';
import 'package:rousseau_vote/src/screens/poll_details_screen.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/screens/register_screen.dart';
import 'package:rousseau_vote/src/screens/account/anagraph_screen.dart';
import 'package:rousseau_vote/src/screens/edit_account_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configure();

  final ErrorLogger errorLogger = await getIt.getAsync();

  if (errorLogger.isEnabled()) {
    runAppCatchingErrors(errorLogger);
  } else {
    runAppDefault();
  }
}

void runAppCatchingErrors(ErrorLogger errorLogger) {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZonedGuarded<Future<void>>(() async {
    runApp(RousseauVoteApp());
  }, (Object error, StackTrace stackTrace) {
    errorLogger.reportError(error, stackTrace);
  });
}

void runAppDefault() {
  runApp(RousseauVoteApp());
}

class RousseauVoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildCloneableWidget>[
          // ignore: always_specify_types
          ChangeNotifierProvider(builder: (_) => getIt<Login>()),
          ChangeNotifierProvider<ExternalPreselection>(builder: (_) => getIt<ExternalPreselection>()),
          ChangeNotifierProvider<BlogInstantArticleProvider>(builder: (_) => getIt<BlogInstantArticleProvider>()),
        ],
        child: GraphQLProvider(
            client: getIt(),
            child: CacheProvider(
              child: MaterialApp(
                  title: APP_NAME,
                  theme: ThemeData(
                      fontFamily: 'Poppins',
                      primarySwatch: Colors.red,
                      primaryColor: PRIMARY_RED),
                  navigatorObservers: [
                    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
                  ],
                  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
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
                    '/': (BuildContext context) =>
                        InitScreen(PollsScreen.ROUTE_NAME, getIt()),
                    PollsScreen.ROUTE_NAME: (BuildContext context) =>
                        PollsScreen(),
                    LoginScreen.ROUTE_NAME: (BuildContext context) =>
                        LoginScreen(),
                    RegisterScreen.ROUTE_NAME: (BuildContext context) =>
                        RegisterScreen(),
                    EditAccountScreen.ROUTE_NAME: (BuildContext context) =>
                        EditAccountScreen(),
                    AnagraphScreen.ROUTE_NAME: (BuildContext context) => AnagraphScreen(),
                    
                    LoginInfoScreen.ROUTE_NAME: (BuildContext context) => LoginInfoScreen(),
                    DeleteAccountDisclaimerScreen.ROUTE_NAME: (BuildContext context) => DeleteAccountDisclaimerScreen(),
                    DeleteAccountActionScreen.ROUTE_NAME: (BuildContext context) => DeleteAccountActionScreen(),
                     
                    ResidenceScreen.ROUTE_NAME: (BuildContext context) => ResidenceScreen(),
                    ContactPreferencesScreen.ROUTE_NAME: (BuildContext context) => ContactPreferencesScreen(),
                    PollDetailsScreen.ROUTE_NAME: (BuildContext context) {
                      final PollDetailArguments arguments =
                          ModalRoute.of(context).settings.arguments;
                      return PollDetailsScreen(arguments);
                    },
                    InAppBrowser.ROUTE_NAME: (BuildContext context) {
                      final BrowserArguments arguments =
                          ModalRoute.of(context).settings.arguments;
                      return InAppBrowser(arguments);
                    },
                    BlogScreen.ROUTE_NAME: (BuildContext context) {
                      return BlogScreen();
                    },
                    BlogInstantArticleScreen.ROUTE_NAME: (BuildContext context) {
                      final BlogInstantArticleArguments arguments =
                          ModalRoute.of(context).settings.arguments;
                      return BlogInstantArticleScreen(arguments);
                    },
                    UserProfileScreen.ROUTE_NAME: (BuildContext context) {
                      final UserProfileArguments arguments =
                        ModalRoute.of(context).settings.arguments;
                      return UserProfileScreen(arguments);
                    },
                    FeedbackScreen.ROUTE_NAME:(BuildContext context) {
                      return FeedbackScreen();
                    },
                    SuccessScreen.ROUTE_NAME:(BuildContext context) {
                      return SuccessScreen();
                    },
                  }),
            )));
  }
}
