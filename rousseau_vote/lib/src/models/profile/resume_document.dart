import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/shared/file.dart';

part 'resume_document.g.dart';

@JsonSerializable()
class ResumeDocument {
  ResumeDocument();

  factory ResumeDocument.fromJson(Map<String, dynamic> json) =>
      _$ResumeDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$ResumeDocumentToJson(this);

  List<File> files;
}