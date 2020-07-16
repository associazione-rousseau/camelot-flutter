import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/profile/geographical_scope.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';

part 'user_positions.g.dart';

@JsonSerializable()
class UserPositions {
  UserPositions();

  factory UserPositions.fromJson(Map<String, dynamic> json) => _$UserPositionsFromJson(json);
  Map<String, dynamic> toJson() => _$UserPositionsToJson(this);

  String description;
  GeographicalScope geographicalScope;
  Position position;
  DateTime startsAt;
  DateTime endsAt;
}
