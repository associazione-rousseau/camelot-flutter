import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';

part 'badge.g.dart';

@JsonSerializable()
class Badge {
  Badge();

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);

  String code;
  bool active;

  int get merit => BADGE_MERIT_MAPPING[code];

  String get localImage => 'assets/images/badges/merit${merit}_true.png';
}