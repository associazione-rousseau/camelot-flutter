import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/interface/generic_list_provider.dart';
import 'package:rousseau_vote/src/widgets/ask_for_verification_widget.dart';
import 'package:rousseau_vote/src/widgets/core/list_provider.dart';
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
        child: ChangeNotifierProvider<ListProvider<Poll>>(
          create: (_) {
            final GenericListProvider<PollList, Poll> provider = GenericListProvider<PollList, Poll>();
            provider.onFetcherUpdated(GraphqlFetcher<PollList>(query: listPolls));
            return provider;
          },
          child: RousseauList<ListProvider<Poll>, Poll>(
            pullToRefresh: true,
            itemBuilder: (BuildContext context, Poll poll) => PollCard(poll),
          ),
        )
      ),
    );
  }
}
