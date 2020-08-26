import 'package:json_annotation/json_annotation.dart';

part 'event_place.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class EventPlace {
  EventPlace();

  factory EventPlace.fromJson(Map<String, dynamic> json) => _$EventPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$EventPlaceToJson(this);

  String formattedAddress;
}
