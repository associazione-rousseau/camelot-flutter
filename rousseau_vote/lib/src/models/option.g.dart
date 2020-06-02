// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option()
    ..id = json['id'] as String
    ..text = json['text'] as String
    ..entity = json['entity'] == null
        ? null
        : Entity.fromJson(json['entity'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'entity': instance.entity,
    };
