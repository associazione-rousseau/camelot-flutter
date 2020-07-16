import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'dart:collection';
import 'package:rousseau_vote/src/providers/current_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';


class ContactPreferencesScreen extends StatefulWidget{

  static const String ROUTE_NAME = '/account_preferences';
  static const List<String> checks = <String> ['noLocalEventsEmail','noNationalEventsEmail','noNewsletterEmail','noRousseauEventsEmail','noVoteEmail','noSms'];

  @override
  _ContactPreferencesScreenState createState() => _ContactPreferencesScreenState();
}

class _ContactPreferencesScreenState extends State<ContactPreferencesScreen> {
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();
  List<bool> userBools;
  
  @override
  Widget build(BuildContext context){
    
    final String title = RousseauLocalizations.of(context).text(
        'edit-account-contact');

    final CurrentUserProvider provider = Provider.of<CurrentUserProvider>(context);
    final CurrentUser currentUser = provider.getCurrentUser();

    userBools = userBools ??  <bool> [currentUser.noLocalEventsEmail,
     currentUser.noNationalEventsEmail,
     currentUser.noNewsletterEmail,
     currentUser.noRousseauEventsEmail,
     currentUser.noVoteEmail,
     currentUser.noSms
    ]; 

    Widget body;

    if (currentUser != null) {
      body = _currentUserBody(currentUser);
    } else if (provider.isLoading()) {
      body = _loadingBody();
    } else {
      body = _errorBody();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }

  Widget _errorBody() {
    return const Text('Error');
  }

  Widget _loadingBody() {
    return const LoadingIndicator();
  }

  Widget _currentUserBody(CurrentUser currentUser) {
    return Column(
      children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: ContactPreferencesScreen.checks.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    RousseauLocalizations.getText(context,ContactPreferencesScreen.checks[index]),
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: Switch(value: userBools[index], onChanged: (bool newVal) {
                    setState(() {
                      userBools[index] = newVal;
                    });
                  }),
                );
              }
            ),
          ),
          GraphQLProvider(
            client: getIt<ValueNotifier<GraphQLClient>>(),
            child: Mutation(
              options: MutationOptions(
                documentNode: gql(userContactPreferencesUpdate),
                update: (Cache cache, QueryResult result) {
                  String message;

                  if (result.hasException) {
                    message = 'error-generic';
                  }

                  final Map<String, Object> user = (result.data as Map<String, Object>)['user'] as Map<String, Object>;
                  final LazyCacheMap map = user.values.first;
                  final List<Object> errors = map.values.first;
                  message = errors == null || errors.isEmpty
                      ? 'info-saved'
                      : 'error-generic';

                  showRousseauSnackbar(context, _scaffoldState, message);
                },
              ),
              builder: (RunMutation runMutation, QueryResult result) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: RoundedButton(
                    text: "SALVA",
                    loading: result.loading,
                    onPressed: () {
                      Map<String, dynamic> variables =
                          HashMap<String, dynamic>();
                      variables.putIfAbsent(
                          'user', 
                          () => <String,bool>{
                            'noLocalEventsEmail': userBools[0],
                            'noNationalEventsEmail': userBools[1],
                            'noNewsletterEmail': userBools[2],
                            'noRousseauEventsEmail': userBools[3],
                            'noVoteEmail': userBools[4],
                            'noSms': userBools[5],
                          });
                      return runMutation(
                        variables,
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
    );
  }
}