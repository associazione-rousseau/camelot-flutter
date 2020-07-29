// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entity _$EntityFromJson(Map<String, dynamic> json) {
  return Entity()
    ..id = json['id'] as String
    ..fullName = json['fullName'] as String
    ..slug = json['slug'] as String
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>)
    ..badges = (json['badges'] as List)
        ?.map(
            (e) => e == null ? null : Badge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['__typename'] as String;
}

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'slug': instance.slug,
      'profile': instance.profile,
      'badges': instance.badges,
      '__typename': instance.type,
    };
