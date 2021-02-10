// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..id = json['id'] as String
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..parent = json['parent'] == null
        ? null
        : Tag.fromJson(json['parent'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'parent': instance.parent,
    };
