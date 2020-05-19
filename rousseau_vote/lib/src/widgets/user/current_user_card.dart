import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

import '../graphql_query_widget.dart';
import '../loading_indicator.dart';

class CurrentUserCard extends StatelessWidget {
  const CurrentUserCard();

  @override
  Widget build(BuildContext context) {
    return GraphqlQueryWidget<CurrentUser>(
        query: currentUserShort,
        builderSuccess: (CurrentUser currentUser) {
          return ListTile(
            leading: ProfilePicture(currentUser.getProfilePictureUrl()),
            title: Text(
              currentUser.fullName,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(currentUser.slug),
          );
        },
        builderLoading: () {
          return const Center(
              child: ListTile(
            leading: LoadingIndicator(),
          ));
        },
        builderError: (List<GraphQLError> errors) {
          return Text(errors.toString());
        });
  }
}
