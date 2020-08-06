import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/user/profile.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';

part 'entity.g.dart';

@JsonSerializable()
class Entity {
  Entity();

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
  Map<String, dynamic> toJson() => _$EntityToJson(this);

  String id;
  String fullName;
  String slug;
  String overseaseCity;
  Profile profile;
  List<Badge> badges;
  @JsonKey(name: '__typename')
  String type;

  String get residence => overseaseCity ?? profile.placeOfResidence.comuneName;

  bool hasBadge(int badgeNumber) {
    for (Badge badge in badges) {
      if(badge.merit == badgeNumber) {
        return true;
      }
    }
    return false;
  }

  String getProfilePictureUrl() {
    if(profile == null || profile.picture == null) {
      return null;
    }
    return profile.picture.originalUrl;
  }

}