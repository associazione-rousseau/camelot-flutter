
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/user_profile_widget.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class UserProfileScreen extends StatelessWidget {

  const UserProfileScreen(this._arguments);

  static const String ROUTE_NAME = '/user_profile';

  final UserProfileArguments _arguments;

  @override
  Widget build(BuildContext context) {
    final HashMap<String, String> variables = _arguments.currentUser ? null : HashMap<String, String>.of({'id': _arguments.slug});
    final String query = _arguments.currentUser ? currentUserFull : profileDetail;

    return Scaffold(
      body: GraphqlQueryWidget<UserProfile>(
      query: query,
      variables: variables,
      fetchPolicy: FetchPolicy.cacheFirst,
      builderSuccess: (UserProfile userProfile) {
        return UserProfileWidget(userProfile: userProfile);
      },
      builderLoading: () {
        return const UserProfileWidget(isLoading: true);
      },
      builderError: (List<GraphQLError> error) {
        Navigator.of(context).pop();
        showSimpleSnackbar(context, textKey: 'error-network');

        return Text(error.toString());
      },
    ),
    );
  }

}

class UserProfileArguments {

  const UserProfileArguments({ this.slug });

  final String slug;

  bool get currentUser => slug == null;
}
