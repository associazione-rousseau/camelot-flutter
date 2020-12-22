import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/models/user.dart';

String subscriberString(BuildContext context, UserProfile userProfile) =>
    miFidoString(
        context, userProfile.subscriptionCount ?? 0, userProfile.firstSubscriber);

String subscribedString(BuildContext context, UserProfile userProfile) =>
    miFidoString(
        context, userProfile.userPublicSubscriptions?.totalCount ?? 0, userProfile.firstSubscribed);

String miFidoString(BuildContext context, int count, User user) {
  if (count == 0) {
    return RousseauLocalizations.getText(context, 'mi-fido-count-zero');
  }
  if (count == 1) {
    return RousseauLocalizations.getTextFormatted(
        context, 'mi-fido-count-one', <String>[
      user.fullName,
    ]);
  }
  return RousseauLocalizations.getTextFormatted(
      context, 'mi-fido-count-plural', <dynamic>[user.fullName, count]);
}
