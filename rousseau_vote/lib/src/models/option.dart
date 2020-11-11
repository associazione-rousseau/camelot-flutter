import 'package:flutter/cupertino.dart';
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

  @JsonKey(name: '__typename')
  String type;

  bool get isEntityUserType => type == 'EntityOption' && entity.type == 'User';

  @override
  bool operator ==(dynamic other) => other is Option && id != null && id == other.id;

  @override
  int get hashCode => id.hashCode;
}