// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageLevel _$LanguageLevelFromJson(Map<String, dynamic> json) {
  return LanguageLevel()
    ..language = json['language'] == null
        ? null
        : Language.fromJson(json['language'] as Map<String, dynamic>)
    ..level = json['level'] as String;
}

Map<String, dynamic> _$LanguageLevelToJson(LanguageLevel instance) =>
    <String, dynamic>{
      'language': instance.language,
      'level': instance.level,
    };
