import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/config/links.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/screens/edit_account_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/verify_identity_util.dart';
import 'package:rousseau_vote/src/widgets/dialog/loading_dialog.dart';
import 'package:rousseau_vote/src/widgets/drawer/drawer_item.dart';
import 'package:rousseau_vote/src/widgets/drawer/rousseau_drawer_header.dart';
import 'package:rousseau_vote/src/widgets/feedback/feedback_category_dialog.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';

class RousseauDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphqlQueryWidget<CurrentUser>(
        query: currentUserShort,
        fetchPolicy: FetchPolicy.cacheFirst,
        builderSuccess: (CurrentUser currentUser) =>
            _drawer(context, currentUser: currentUser),
        builderLoading: () => _drawer(context, isLoading: true),
        builderError: (List<GraphQLError> errors) =>
            _drawer(context, errors: errors));
  }

  Widget _drawer(BuildContext context,
      {CurrentUser currentUser,
      bool isLoading = false,
      List<GraphQLError> errors}) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: 230,
              child: RousseauDrawerHeader(
                currentUser: currentUser,
                isLoading: isLoading,
                errors: errors,
              )),
          currentUser != null && currentUser.shouldVerifyIdentity
              ? DrawerItem(
                  textKey: 'drawer-verify-identity',
                  iconData: Icons.verified_user,
                  color: PRIMARY_RED,
                  onTap: () => openVerifyIdentityScreen(context),
                )
              : Container(),
          DrawerItem(
            textKey: 'profile',
            iconData: Icons.person,
            onTap: () {
              openCurrentUserProfile(context, currentUser);
            },
          ),
          DrawerItem(
              textKey: 'drawer-feedback',
              iconData: Icons.feedback,
              onTap: () => _onSendFeedbackTapped(context)),
          DrawerItem(
            textKey: 'drawer-edit-account',
            iconData: Icons.settings,
            onTap: openRouteAction(context, EditAccountScreen.ROUTE_NAME),
          ),
          const Divider(height: 4),
          DrawerItem(
            textKey: 'drawer-support',
            iconData: Icons.favorite,
            onTap: openUrlExternalAction(context, SUPPORT_LINK),
          ),
          DrawerItem(
            textKey: 'drawer-web-version',
            iconData: Icons.devices,
            onTap: openUrlExternalAction(context, ROUSSEAU_WEB_LINK),
          ),
          DrawerItem(
            textKey: 'drawer-privacy',
            iconData: Icons.security,
            onTap: openUrlExternalAction(context, PRIVACY_LINK),
          ),
          const Divider(height: 4),
          DrawerItem(
            textKey: 'drawer-logout',
            iconData: Icons.exit_to_app,
            onTap: () => _onLogoutTapped(context),
          ),
        ],
      ),
    );
  }

  void _onSendFeedbackTapped(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return FeedbackCategoryDialog();
        });
  }

  void _onLogoutTapped(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          Provider.of<Login>(context, listen: false)
              .logout()
              .then((dynamic result) =>
                  Navigator.of(dialogContext, rootNavigator: true).pop())
              .catchError((dynamic error) {
            Navigator.of(dialogContext, rootNavigator: true).pop();
            showSimpleSnackbar(context, textKey: 'error-network');
          });
          return const LoadingDialog(
            titleKey: 'message-logging-out',
          );
        });
  }
}
