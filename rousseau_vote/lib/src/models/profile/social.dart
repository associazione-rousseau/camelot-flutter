import 'package:json_annotation/json_annotation.dart';

part 'social.g.dart';

@JsonSerializable()
class Social {
  Social();

  factory Social.fromJson(Map<String, dynamic> json) =>
      _$SocialFromJson(json);
  Map<String, dynamic> toJson() => _$SocialToJson(this);

  String code;
}