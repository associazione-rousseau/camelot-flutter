// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author()
    ..name = json['name'] as String
    ..avatar = json['avatar'] as String
    ..rousseauSlug = json['rousseau_slug'] as String;
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'rousseau_slug': instance.rousseauSlug,
    };
