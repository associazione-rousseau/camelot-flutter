import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';

class ContactPreferencesScreen extends StatefulWidget{

  static const String ROUTE_NAME = '/account_preferences';
  static const List<String> checks = <String> ['noLocalEventsEmail','noNationalEventsEmail','noNewsletterEmail','noRousseauEventsEmail','noVoteEmail','noSms'];

  @override
  _ContactPreferencesScreenState createState() => _ContactPreferencesScreenState();
}

class _ContactPreferencesScreenState extends State<ContactPreferencesScreen> {
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();
  List<bool> newBools;
  List<bool> originalBools;

  
  @override
  Widget build(BuildContext context){
    
    final String title = RousseauLocalizations.of(context).text(
        'edit-account-contact');

  
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(title),
      ),
      body: GraphqlQueryWidget<CurrentUser>(
        query: currentUserFull,
        builderSuccess: (CurrentUser currentUser) {
          return _currentUserBody(currentUser);
        },
        builderLoading: () {
          return const LoadingIndicator();
        },
        builderError: (List<GraphQLError> error) {
          return Text(error.toString());
        },
      ),
    );
  }

  Widget _errorBody() {
    return const Text('Error');
  }

  Widget _loadingBody() {
    return const LoadingIndicator();
  }

  Widget _currentUserBody(CurrentUser currentUser) {
    originalBools = originalBools ??  <bool> [currentUser.noLocalEventsEmail,
     currentUser.noNationalEventsEmail,
     currentUser.noNewsletterEmail,
     currentUser.noRousseauEventsEmail,
     currentUser.noVoteEmail,
     currentUser.noSms
    ]; 
    newBools = newBools ??  <bool> [currentUser.noLocalEventsEmail,
     currentUser.noNationalEventsEmail,
     currentUser.noNewsletterEmail,
     currentUser.noRousseauEventsEmail,
     currentUser.noVoteEmail,
     currentUser.noSms
    ]; 
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
                  trailing: Switch(value: newBools[index], onChanged: (bool newVal) {
                    setState(() {
                      newBools[index] = newVal;
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
                    text: RousseauLocalizations.getText(context, 'save').toUpperCase(),
                    loading: result.loading,
                    onPressed: preferencesChanged() == true ? () {
                      Map<String, dynamic> variables =
                          HashMap<String, dynamic>();
                      variables.putIfAbsent(
                          'user', 
                          () => <String,bool>{
                            'noLocalEventsEmail': newBools[0],
                            'noNationalEventsEmail': newBools[1],
                            'noNewsletterEmail': newBools[2],
                            'noRousseauEventsEmail': newBools[3],
                            'noVoteEmail': newBools[4],
                            'noSms': newBools[5],
                          });
                      return runMutation(
                        variables,
                      );
                    } : null,
                  ),
                );
              },
            ),
          )
        ],
    );
  }
  bool preferencesChanged(){
    bool flag = false;
    originalBools.asMap().forEach((int index, bool value) { 
      print('old: ' + originalBools[index].toString() + ', new: ' + newBools[index].toString());
      if(newBools[index] != value){
        flag = true;
      }
    });
    return flag;
  }
}