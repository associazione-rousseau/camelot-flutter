import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';
import 'package:rousseau_vote/src/models/profile/category.dart';
import 'package:rousseau_vote/src/models/profile/profile.dart';
import 'package:rousseau_vote/src/models/profile/tag.dart';
import 'package:rousseau_vote/src/models/profile/user_positions.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  UserProfile();

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  String id;
  String slug;
  String accountType;
  String gender;
  String fullName;
  String lastName;
  String firstName;
  List<Badge> badges;
  Category category;
  List<Tag> tags;
  Profile profile;
  List<UserPositions> userPositions;

  String get residence {
    if (profile?.placeOfResidence == null) {
      return '';
    }
    if(profile.placeOfResidence.overseaseCity != null) {
      return profile.placeOfResidence.overseaseCity;
    }
    return profile.placeOfResidence.comuneName;
  }

  String get profilePictureUrl {
    if (profile == null || profile.picture == null) {
      return null;
    }
    return profile.picture.originalUrl;
  }

  bool get female => gender == 'F';
  bool get male => gender == 'M';
}
