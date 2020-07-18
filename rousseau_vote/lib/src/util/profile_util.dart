import 'package:rousseau_vote/src/models/profile/badge.dart';

const Map<String, int> BADGE_MERIT_MAPPING = <String, int>{
  'list_representative': 1,
  'italia_cinque_stelle_volunteer': 1,
  'villaggio_rousseau_volunteer': 1,
  'call_to_actions_organizer': 2,
  'activism_organizer': 2,
  'sharing_proposer': 2,
  'user_lex_proposer': 2,
  'graduate': 3,
  'english_language_expert': 4,
  'openday_participant': 5,
  'villaggio_rousseau_participant': 5,
  'elearnign_student': 6,
  'special_mentions': 7,
  'high_specialization' : 8,
  'community_leader': 9,
};

const int BADGES_NUMBER = 9;

List<String> getBadgesImages(List<Badge> badges, { bool showInactive = false }) {
  final List<bool> isBadgeActive = List<bool>.filled(BADGES_NUMBER, false, growable: false);
  for(Badge badge in badges) {
    if(badge.active) {
      final int badgeNumber = BADGE_MERIT_MAPPING[badge.code];
      isBadgeActive[badgeNumber - 1] = true;
    }
  }
  final List<String> images = <String>[];
  for(int i = 1; i <= BADGES_NUMBER; i++) {
    if(isBadgeActive[i - 1]) {
      images.add(badgeAsset(i, true));
    } else if(showInactive) {
      images.add(badgeAsset(i, false));
    }
  }
  return images;
}

String badgeAsset(int badgeNumber, bool active) {
  return 'assets/images/badges/merit${badgeNumber}_${active.toString()}.png';
}
