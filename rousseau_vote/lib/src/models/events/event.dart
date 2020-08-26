import 'package:json_annotation/json_annotation.dart';

import 'event_place.dart';

part 'event.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Event {
  Event();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  String title;
  String campaign;
  String image;
  String permalink;
  String marker;

  EventPlace place;
}
