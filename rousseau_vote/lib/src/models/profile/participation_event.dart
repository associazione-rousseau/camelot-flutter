import 'package:json_annotation/json_annotation.dart';

part 'participation_event.g.dart';

@JsonSerializable()
class ParticipationEvent {
  ParticipationEvent();

  factory ParticipationEvent.fromJson(Map<String, dynamic> json) =>
      _$ParticipationEventFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipationEventToJson(this);

  String title;
  String typology;
  DateTime startsAt;
  DateTime endsAt;
}
