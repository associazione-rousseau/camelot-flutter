import 'package:json_annotation/json_annotation.dart';

import 'language.dart';

part 'language_level.g.dart';

@JsonSerializable()
class LanguageLevel {
  LanguageLevel();

  factory LanguageLevel.fromJson(Map<String, dynamic> json) =>
      _$LanguageLevelFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageLevelToJson(this);

  Language language;
  String level;
}