import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

import 'dialog_util.dart';

const Map<String, int> BADGE_MERIT_MAPPING = <String, int>{
  'list_representative': 0,
  'italia_cinque_stelle_volunteer': 0,
  'villaggio_rousseau_volunteer': 0,
  'call_to_actions_organizer': 1,
  'activism_organizer': 1,
  'sharing_proposer': 1,
  'user_lex_proposer': 1,
  'graduate': 2,
  'english_language_expert': 3,
  'openday_participant': 4,
  'villaggio_rousseau_participant': 4,
  'elearnign_student': 5,
  'special_mentions': 6,
  'high_specialization': 7,
  'community_leader': 8,
};

const int BADGES_NUMBER = 9;

List<String> getBadgesImages(List<Badge> badges, {bool showInactive = false}) {
  final List<bool> isBadgeActive =
      List<bool>.filled(BADGES_NUMBER, false, growable: false);
  for (Badge badge in badges) {
    if (badge.active) {
      final int badgeNumber = BADGE_MERIT_MAPPING[badge.code];
      isBadgeActive[badgeNumber] = true;
    }
  }
  final List<String> images = <String>[];
  for (int i = 0; i < BADGES_NUMBER; i++) {
    if (isBadgeActive[i]) {
      images.add(badgeAsset(i, true));
    } else if (showInactive) {
      images.add(badgeAsset(i, false));
    }
  }
  return images;
}

String badgeAsset(int badgeNumber, bool active) {
  return 'assets/images/badges/merit${badgeNumber + 1}_${active.toString()}.png';
}

String getUserSubtitleShort(BuildContext context, int age, String residence) {
  if (age == null) {
    return residence ?? '';
  }
  if (residence == null) {
    return getAgeString(context, age);
  }
  return '${getAgeString(context, age)}, $residence';
}

String getUserSubtitle(BuildContext context, int age, String placeOfBirth,
    String residence, bool isFemale) {
  final String ageString = getAgeString(context, age);
  final String location =
      getFormattedLocation(context, placeOfBirth, residence, isFemale);
  return '$ageString - $location';
}

String getAgeString(BuildContext context, int age) {
  return RousseauLocalizations.getTextFormatted(context, 'profile-age', <int>[age]);
}

String getFormattedLocation(BuildContext context, String placeOfBirth,
    String residence, bool isFemale) {
  final bool samePlace = placeOfBirth == residence;

  if (samePlace) {
    final String rawStringKey = isFemale
        ? 'profile-location-same-female'
        : 'profile-location-same-male';
    return RousseauLocalizations.getTextFormatted(
        context, rawStringKey, <String>[residence]);
  }
  final String rawStringKey =
      isFemale ? 'profile-location-female' : 'profile-location-male';

  return RousseauLocalizations.getTextFormatted(
      context, rawStringKey, <String>[placeOfBirth, residence]);
}

void maybeShowCompileProfileDialog(BuildContext context, { int delay = 0 }) {
  getIt<UserNetworkHandler>()
      .fetchCurrentUser(fetchPolicy: FetchPolicy.cacheFirst)
      .then((CurrentUser currentUser) {
    if (!currentUser.hasCompiledProfile) {
      Future<void>.delayed(Duration(seconds : delay), () {
        showCompileProfileDialog(context);
      });
    }
  });
}

void showCompileProfileDialog(BuildContext context) {
  showAlertDialog(context,
      barrierDismissible: false,
      titleKey: 'profile-not-compiled',
      messageKey: 'profile-not-compiled-alert-message',
      buttonKey1: 'back',
      buttonKey2: 'profile-compile-now',
      buttonAction1: () => Navigator.pop(context),
      buttonAction2: () {
        Navigator.pop(context);
        openEditProfileExternal(context);
      });
}

void openEditProfileExternal(BuildContext context) {
  openUrlExternal(context, ROUSSEAU_EDIT_PROFILE_URL);
}
