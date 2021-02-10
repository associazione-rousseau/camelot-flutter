import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/profile/geographical_scope.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';

part 'user_position.g.dart';

@JsonSerializable()
class UserPosition {
  UserPosition();

  factory UserPosition.fromJson(Map<String, dynamic> json) => _$UserPositionFromJson(json);
  Map<String, dynamic> toJson() => _$UserPositionToJson(this);

  String description;
  GeographicalScope geographicalScope;
  Position position;
  DateTime startsAt;
  DateTime endsAt;
}
