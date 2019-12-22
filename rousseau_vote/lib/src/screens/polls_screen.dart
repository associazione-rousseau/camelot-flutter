import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/poll_card.dart';

import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class PollsScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      appBar: RousseauAppBar(),
      body: GraphqlQueryWidget<PollList>(
        query: listPolls,
        builderSuccess: (PollList pollList) {
          return ListView.builder(
            itemCount: pollList.polls.length,
            itemBuilder: (BuildContext context, int index) => PollCard(pollList.polls[index])
          );
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
