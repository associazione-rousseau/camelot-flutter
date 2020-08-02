// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectUpload _$DirectUploadFromJson(Map<String, dynamic> json) {
  return DirectUpload()
    ..url = json['url'] as String
    ..headers = json['headers'] == null
        ? null
        : DirectUploadHeaders.fromJson(json['headers'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DirectUploadToJson(DirectUpload instance) =>
    <String, dynamic>{
      'url': instance.url,
      'headers': instance.headers,
    };
