import 'package:json_annotation/json_annotation.dart';
part 'badge.g.dart';

@JsonSerializable()
class Badge {
  Badge();

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);

  String code;
  String name;
  bool active;
}