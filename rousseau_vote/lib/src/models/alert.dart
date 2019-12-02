import 'package:json_annotation/json_annotation.dart';

part 'alert.g.dart';

@JsonSerializable()
class Alert {
  Alert();

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);
  Map<String, dynamic> toJson() => _$AlertToJson(this);

  String message;
}