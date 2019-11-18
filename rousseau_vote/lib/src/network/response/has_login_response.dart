import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
mixin HasLoginUrl {
  String loginUrl;
}