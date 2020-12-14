// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeDocument _$ResumeDocumentFromJson(Map<String, dynamic> json) {
  return ResumeDocument()
    ..files = (json['files'] as List)
        ?.map(
            (e) => e == null ? null : File.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ResumeDocumentToJson(ResumeDocument instance) =>
    <String, dynamic>{
      'files': instance.files,
    };
