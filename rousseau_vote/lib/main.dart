import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:rousseau_vote/src/screens/account/login_info_screen.dart';
import 'package:rousseau_vote/src/screens/account/residence_screen.dart';
import 'package:rousseau_vote/src/screens/blog_instant_article_screen.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';
import 'package:rousseau_vote/src/screens/init_screen.dart';
import 'package:rousseau_vote/src/screens/login_screen.dart';
import 'package:rousseau_vote/src/screens/poll_details_screen.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/screens/register_screen.dart';
import 'package:rousseau_vote/src/screens/edit_account_screen.dart';
import 'package:rousseau_vote/src/screens/account/anagraph_screen.dart';

void main() {
  configure();

  runApp(RousseauVoteApp());
}

class RousseauVoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildCloneableWidget>[
          // ignore: always_specify_types
          ChangeNotifierProvider(builder: (_) => getIt<Login>()),
          ChangeNotifierProvider<ExternalPreselection>(
              builder: (_) => getIt<ExternalPreselection>()),
          ChangeNotifierProvider<BlogInstantArticleProvider>(
              builder: (_) => getIt<BlogInstantArticleProvider>()),
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
                  localizationsDelegates: const <
                      LocalizationsDelegate<dynamic>>[
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
                    AnagraphScreen.ROUTE_NAME: (BuildContext context) {
                      final CurrentUser cu =
                          ModalRoute.of(context).settings.arguments;
                      return AnagraphScreen(cu);
                    },
                    LoginInfoScreen.ROUTE_NAME: (BuildContext context) {
                      final CurrentUser cu =
                          ModalRoute.of(context).settings.arguments;
                      return LoginInfoScreen(cu);
                    },
                    ResidenceScreen.ROUTE_NAME: (BuildContext context) {
                      final CurrentUser cu =
                          ModalRoute.of(context).settings.arguments;
                      return ResidenceScreen(cu);
                    },
                    ContactPreferencesScreen.ROUTE_NAME: (BuildContext context) {
                      final CurrentUser cu =
                          ModalRoute.of(context).settings.arguments;
                      return ContactPreferencesScreen(cu);
                    },
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
                    BlogInstantArticleScreen.ROUTE_NAME:
                        (BuildContext context) {
                      final BlogInstantArticleArguments arguments =
                          ModalRoute.of(context).settings.arguments;
                      return BlogInstantArticleScreen(arguments);
                    },
                  }),
            )));
  }
}
