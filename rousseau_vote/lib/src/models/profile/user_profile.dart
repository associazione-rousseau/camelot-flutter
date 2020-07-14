import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/blog/category.dart';
import 'package:rousseau_vote/src/models/profile/tag.dart';

import 'badge.dart';

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
  List<Category> category;
  List<Tag> tags;
}
