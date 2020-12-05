import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/widgets/ask_for_verification_widget.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';

import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/vote/poll_card.dart';

class PollsScreen extends StatelessWidget {
  const PollsScreen();

  static const String ROUTE_NAME = '/polls';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      body: AskForVerificationWidget(
        child: RousseauList<PollList, Poll>(
          pullToRefresh: true,
          fetcher: GraphqlFetcher<PollList>(query: listPolls),
          itemBuilder: (BuildContext context, Poll poll) => PollCard(poll),
        )
      ),
    );
  }
}
