import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/store/token_store.dart';
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
          return _placeholderWidget();
        },
        builderError: (List<GraphQLError> errors) {
          return _placeholderWidget();
        });
  }

  Widget _placeholderWidget() {
    final TokenStore tokenStore = getIt<TokenStore>();
    return ListTile(
      leading: const ProfilePicture('assets/images/profilePlaceholder.png'),
      title: Text(
        tokenStore.getUserFullName(),
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: const Text(''),
    );
  }
}
