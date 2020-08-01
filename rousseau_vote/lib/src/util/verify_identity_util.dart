
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/screens/verify_identity_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

import 'dialog_util.dart';

void maybeShowVerificationDialog(BuildContext context) {
  getIt<UserNetworkHandler>()
      .fetchCurrentUser(fetchPolicy: FetchPolicy.cacheFirst)
      .then((CurrentUser currentUser) {
    if (currentUser.shouldVerifyIdentity) {
      showVerifyIdentityDialog(context);
    }
  });
}

void showVerifyIdentityDialog(BuildContext context) {
  showAlertDialog(context,
      barrierDismissible: false,
      titleKey: 'identity-not-verified',
      messageKey: 'identity-verification-alert-message',
      buttonKey1: 'back',
      buttonKey2: 'identity-verification-verify-now',
      buttonAction1: () => Navigator.pop(context),
      buttonAction2: () {
        Navigator.pop(context);
        openVerifyIdentityScreen(context);
      });
}

void openVerifyIdentityScreen(BuildContext context) {
  openRoute(context, VerifyIdentityScreen.ROUTE_NAME);
}