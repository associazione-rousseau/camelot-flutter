import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/widgets/user/residence_content_body.dart';

class ResidenceScreen extends StatelessWidget {
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();

  static const String ROUTE_NAME = '/account_residence';
  @override
  Widget build(BuildContext context) {
    final String title = RousseauLocalizations.of(context).text('edit-account-residence');

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(title),
      ),
      body: GraphqlQueryWidget<CurrentUser>(
        query: currentUserResidence,
        builderSuccess: (CurrentUser currentUser) {
          return ResidenceContentBody(currentUser);
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
