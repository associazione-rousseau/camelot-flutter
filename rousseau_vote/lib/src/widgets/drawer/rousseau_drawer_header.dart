
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/user/current_user_card.dart';

class RousseauDrawerHeader extends StatelessWidget {

  const RousseauDrawerHeader({ this.currentUser, this.isLoading = false, this.errors });

  final CurrentUser currentUser;
  final bool isLoading;
  final List<GraphQLError> errors;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: CurrentUserCard(currentUser: currentUser, isLoading: isLoading, errors: errors)
    );
  }
}