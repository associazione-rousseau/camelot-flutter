import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/profile/participation_event.dart';

part 'participation.g.dart';

@JsonSerializable()
class Participation {
  Participation();

  factory Participation.fromJson(Map<String, dynamic> json) =>
      _$ParticipationFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipationToJson(this);

  ParticipationEvent event;
  ItalianGeographicalDivision geographicalScope;
  bool staff;
}
