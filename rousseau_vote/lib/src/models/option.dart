import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/entity.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  Option();

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);

  String id;
  String text;
  Entity entity;

}