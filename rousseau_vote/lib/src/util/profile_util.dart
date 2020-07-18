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

List<String> getActiveBadgesImages(List<Badge> badges) {
  final List<String> images = <String>[];
  for(Badge badge in badges) {
    if(badge.active && !images.contains(badge.localImage)) {
      images.add(badge.localImage);
    }
  }
  return images;
}
