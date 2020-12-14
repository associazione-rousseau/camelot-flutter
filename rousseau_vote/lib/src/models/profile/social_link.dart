import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/profile/social.dart';

part 'social_link.g.dart';

@JsonSerializable()
class SocialLink {
  SocialLink();

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinkToJson(this);

  Social social;
  String url;
}