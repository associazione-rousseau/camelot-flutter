import 'package:json_annotation/json_annotation.dart';

part 'curriculum_vitae_document.g.dart';

@JsonSerializable()
class CurriculumVitaeDocument {
  CurriculumVitaeDocument();

  factory CurriculumVitaeDocument.fromJson(Map<String, dynamic> json) => _$CurriculumVitaeDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$CurriculumVitaeDocumentToJson(this);

  String originalUrl;
}
