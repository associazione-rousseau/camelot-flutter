import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class PollsScreen extends StatelessWidget {
  
  static const String ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      GraphqlQueryWidget(
        query: listPolls,
        builderSuccess: (dynamic data) {
          final LazyCacheMap lazyCacheMap = data;
          return Text(lazyCacheMap.data.toString());
        },
        builderLoading: () {
          return const LoadingIndicator();
        },
        builderError: (List<GraphQLError> error) {
          return Text(error.toString());
        },
      )
    );
  }

}