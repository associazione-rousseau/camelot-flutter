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

class ContactPreferencesScreen extends StatefulWidget{

  ContactPreferencesScreen(this.currentUser){
    userBools = <bool> [currentUser.noLocalEventsEmail, currentUser.noNationalEventsEmail, currentUser.noNewsletterEmail, currentUser.noRousseauEventsEmail, currentUser.noVoteEmail, currentUser.noSms];
  }
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();

  static const String ROUTE_NAME = '/account_preferences';
  static const List<String> checks = <String> ['noLocalEventsEmail','noNationalEventsEmail','noNewsletterEmail','noRousseauEventsEmail','noVoteEmail','noSms'];
  List<bool> userBools;
  CurrentUser currentUser;

  @override
  _ContactPreferencesScreenState createState() => _ContactPreferencesScreenState();
}

class _ContactPreferencesScreenState extends State<ContactPreferencesScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: widget._scaffoldState,
      appBar: RousseauAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: ContactPreferencesScreen.checks.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    RousseauLocalizations.getText(context, ContactPreferencesScreen.checks[index]),
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: Switch(value: widget.userBools[index], onChanged: (bool newVal) {
                    print(newVal);
                    setState(() {
                      widget.userBools[index] = newVal;
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

                  showRousseauSnackbar(context, widget._scaffoldState, message);
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
                            'noLocalEventsEmail': widget.userBools[0],
                            'noNationalEventsEmail': widget.userBools[1],
                            'noNewsletterEmail': widget.userBools[2],
                            'noRousseauEventsEmail': widget.userBools[3],
                            'noVoteEmail': widget.userBools[4],
                            'noSms': widget.userBools[5],
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
      ),
    );
  }
}