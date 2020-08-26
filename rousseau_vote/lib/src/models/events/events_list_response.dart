import 'package:json_annotation/json_annotation.dart';

import 'event.dart';

part 'events_list_response.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class EventsListResponse {
  EventsListResponse();

  factory EventsListResponse.fromJson(Map<String, dynamic> json) => _$EventsListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EventsListResponseToJson(this);

  int code;
  String message;
  List<Event> events;

  bool get hasErrors => code != null;
  bool get isSuccess => !hasErrors;
  bool get hasNoEvents => code == 500;
}
