
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/user/user_card.dart';

class ActivistsScreen extends StatelessWidget {

  const ActivistsScreen();

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      body: RousseauList<ProfileSearch, User>(
            fetcher: GraphqlFetcher<ProfileSearch>(query: profileSearch),
            itemBuilder: (BuildContext context, User user) => UserCard(user: user),
      ),
    );
  }
}
