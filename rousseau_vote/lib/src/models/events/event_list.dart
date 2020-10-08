import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/events/event.dart';

part 'event_list.g.dart';

@JsonSerializable(nullable: true)
class EventList {
  EventList();

  factory EventList.fromJson(Map<String, dynamic> json) => _$EventListFromJson(json);
  Map<String, dynamic> toJson() => _$EventListToJson(this);

  List<Event> events;
  String label;

  bool get hasEvents => events != null && events.isNotEmpty;
}
