import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';

part 'positions.g.dart';

@JsonSerializable()
class Positions {
  Positions();

  factory Positions.fromJson(Map<String, dynamic> json) => _$PositionsFromJson(json);
  Map<String, dynamic> toJson() => _$PositionsToJson(this);

  List<Position> positions;


}
