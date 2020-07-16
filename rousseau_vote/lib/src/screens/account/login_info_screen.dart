import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/widgets/label_value.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginInfoScreen extends StatelessWidget {
  LoginInfoScreen();
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();

  static const String ROUTE_NAME = '/account_login_info';
  TextEditingController _emailController;
  TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {

    final String title = RousseauLocalizations.of(context).text('edit-account-login');
   
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(title),
      ),
      body: GraphqlQueryWidget<CurrentUser>(
        query: currentUserFull,
        builderSuccess: (CurrentUser currentUser) {
          return _currentUserBody(currentUser,context);
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

  Widget _currentUserBody(CurrentUser currentUser, BuildContext context) {
    //todo remove mutation and create separated widget
    return Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                LabelValue(_emailController = TextEditingController(text: currentUser.email), 'Email', true),
                LabelValue(_phoneNumberController = TextEditingController(text: currentUser.phoneNumber), 'Numero di telefono', true),
              ],
            ),
          ),
          GraphQLProvider(
            client: getIt<ValueNotifier<GraphQLClient>>(),
            child: Mutation(
              options: MutationOptions(
                documentNode: gql(userAccessDataUpdate),
                update: (Cache cache, QueryResult result) {
                  String message;

                  if (result.hasException) {
                    print('exception');
                  }

                  final Map<String, Object> user = (result.data
                      as Map<String, Object>)['user'] as Map<String, Object>;
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
                          () => {
                                'phoneNumber': _phoneNumberController.text,
                                'email': _emailController.text
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
