import 'package:json_annotation/json_annotation.dart';

part 'event_date.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class EventDate {
  EventDate();

  factory EventDate.fromJson(Map<String, dynamic> json) => _$EventDateFromJson(json);
  Map<String, dynamic> toJson() => _$EventDateToJson(this);

  String date;
  String start;
  String end;
  @JsonKey(fromJson: parseTimestamp)
  DateTime timestamp;

  static DateTime parseTimestamp(String timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
}
