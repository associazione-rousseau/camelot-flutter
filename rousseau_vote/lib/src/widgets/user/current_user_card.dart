import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';

import '../graphql_query_widget.dart';

class CurrentUserCard extends StatelessWidget {
  const CurrentUserCard();

  @override
  Widget build(BuildContext context) {
    return GraphqlQueryWidget<CurrentUser>(
        query: currentUserShort,
        builderSuccess: (CurrentUser currentUser) {
          return Text(currentUser.fullName);
        },
        builderLoading: () {
          return const Text('loading');
        },
        builderError: (List<GraphQLError> errors) {
          return Text(errors.toString());
        });
  }
}
