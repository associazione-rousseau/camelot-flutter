import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/user/profile.dart';

part 'entity.g.dart';

@JsonSerializable()
class Entity {
  Entity();

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
  Map<String, dynamic> toJson() => _$EntityToJson(this);

  String id;
  String fullName;
  String slug;
  Profile profile;

  String getProfilePictureUrl() {
    if(profile == null || profile.picture == null) {
      return null;
    }
    return profile.picture.originalUrl;
  }

}