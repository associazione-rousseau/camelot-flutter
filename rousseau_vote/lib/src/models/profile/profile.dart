import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/profile/language_level.dart';
import 'package:rousseau_vote/src/models/profile/place_of_residence.dart';
import 'package:rousseau_vote/src/models/profile/social_link.dart';
import 'package:rousseau_vote/src/models/user/picture.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  int age;
  String placeOfBirth;
  PlaceOfResidence placeOfResidence;
  Picture picture;

  String presentation;
  String curriculumActivist;
  String curriculumVitae;
  String politicalExperiences;
  String studyCourse;
  String yearOfGraduation;
  String qualification;
  String educationalInstitute;
  List<LanguageLevel> languageLevels;
  List<SocialLink> socialLinks;

  String get facebookProfile => getSocialLink('fb');
  String get twitterProfile => getSocialLink('tw');
  String get linkedinProfile => getSocialLink('ln');

  String getSocialLink(String code) {
    if (socialLinks == null) {
      return null;
    }
    for (SocialLink socialLink in socialLinks) {
      if (socialLink.social.code == code) {
        return socialLink.url;
      }
    }
    return null;
  }
}
