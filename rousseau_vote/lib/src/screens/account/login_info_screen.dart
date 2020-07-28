import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/widgets/login_info_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
          return LoginInfoWidget(currentUser.email,currentUser.phoneNumber, _scaffoldState);
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
}
