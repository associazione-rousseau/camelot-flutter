import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/blog/category.dart';
import 'package:rousseau_vote/src/models/profile/profile.dart';
import 'package:rousseau_vote/src/models/profile/tag.dart';

import 'badge.dart';
import 'user_positions.dart';

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
  String overseaseCity;
  Profile profile;
  List<UserPositions> userPositions;

  String get residence => overseaseCity ?? profile.placeOfResidence.comuneName;

  bool isFemale() {
    return gender == 'F';
  }
}
