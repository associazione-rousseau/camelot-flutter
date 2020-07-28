import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/prefetch/prefetch_manager.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/poll_card.dart';

import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/vote/poll_card_v2.dart';

class PollsScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/polls';

  @override
  Widget build(BuildContext context) {
    final PrefetchManager prefetchManager = getIt<PrefetchManager>();
    FetchPolicy fetchPolicy = FetchPolicy.cacheAndNetwork;
    if (prefetchManager.hasPrefetchedData(listPolls)) {
      prefetchManager.invalidateQuery(listPolls);
      fetchPolicy = FetchPolicy.cacheFirst;
    }

    return RousseauLoggedScaffold(
      appBar: RousseauAppBar(),
      body: GraphqlQueryWidget<PollList>(
        query: listPolls,
        fetchPolicy: fetchPolicy,
        builderSuccess: (PollList pollList) {
          final List<Poll> polls = sortedPolls(pollList);
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(10),
            itemCount: polls.length,
            itemBuilder: (BuildContext context, int index) {
              return PollCardV2(polls[index]);
            }
          );
        },
        builderLoading: () {
          return const LoadingIndicator();
        },
        builderError: (List<GraphQLError> error) {
          return Text(error.toString());
        },
        pullToRefresh: true,
      )
    );
  }

  List<Poll> sortedPolls(PollList list) {
    final List<Poll> result = <Poll>[];
    result.addAll(list.polls.where((Poll p) => p.pollStatus == PollStatus.OPEN));
    result.addAll(list.polls.where((Poll p) => p.pollStatus == PollStatus.PUBLISHED));
    result.addAll(list.polls.where((Poll p) => p.pollStatus == PollStatus.CLOSED));
    return result;
  }

}
