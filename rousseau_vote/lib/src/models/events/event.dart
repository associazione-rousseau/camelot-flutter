import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/events/event_date.dart';

import 'event_place.dart';

part 'event.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Event {
  Event();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  String title;
  String campaign;
  @JsonKey(name: 'image')
  String squareImage;
  String coverImage;
  String permalink;
  String marker;

  @JsonKey(fromJson: parseDates)
  List<EventDate> dates;

  EventPlace place;

  String get location => place.formattedAddress;

  static List<EventDate> parseDates(Map<String, dynamic> datesJson) {
    final List<EventDate> dates = <EventDate>[];
    for(String key in datesJson.keys) {
      dates.add(EventDate.fromJson(datesJson[key]));
    }
    return dates;
  }
}
