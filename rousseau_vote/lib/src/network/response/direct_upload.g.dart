// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectUpload _$DirectUploadFromJson(Map<String, dynamic> json) {
  return DirectUpload(
    json['url'] as String,
    (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$DirectUploadToJson(DirectUpload instance) =>
    <String, dynamic>{
      'url': instance.url,
      'headers': instance.headers,
    };
