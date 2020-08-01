// This widget ask the user to upload the ID if not verified yet

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/screens/verify_identity_screen.dart';
import 'package:rousseau_vote/src/util/dialog_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

class AskForVerificationWidget extends StatefulWidget {
  const AskForVerificationWidget({@required this.child});

  final Widget child;

  @override
  _AskForVerificationWidgetState createState() =>
      _AskForVerificationWidgetState();
}

class _AskForVerificationWidgetState extends State<AskForVerificationWidget>
    with AfterLayoutMixin<AskForVerificationWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getIt<UserNetworkHandler>()
        .fetchCurrentUser(fetchPolicy: FetchPolicy.cacheFirst)
        .then((CurrentUser currentUser) {
      if (currentUser.shouldVerifyIdentity) {
        _showVerifyIdentityDialog(context);
      }
    });
  }

  void _showVerifyIdentityDialog(BuildContext context) {
    showAlertDialog(context,
        titleKey: 'identity-not-verified',
        messageKey: 'identity-verification-alert-message',
        buttonKey1: 'back',
        buttonKey2: 'identity-verification-verify-now',
        buttonAction1: () => Navigator.pop(context),
        buttonAction2: () {
          Navigator.pop(context);
          openRoute(context, VerifyIdentityScreen.ROUTE_NAME);
        });
  }
}
