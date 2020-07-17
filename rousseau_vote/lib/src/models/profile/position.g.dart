// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) {
  return Position()
    ..code = json['code'] as String
    ..type = json['type'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'code': instance.code,
      'type': instance.type,
      'name': instance.name,
    };
