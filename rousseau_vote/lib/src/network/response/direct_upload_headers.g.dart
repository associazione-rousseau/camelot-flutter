// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_upload_headers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectUploadHeaders _$DirectUploadHeadersFromJson(Map<String, dynamic> json) {
  return DirectUploadHeaders()
    ..contentType = json['Content-Type'] as String
    ..contentMd5 = json['Content-MD5'] as String;
}

Map<String, dynamic> _$DirectUploadHeadersToJson(
        DirectUploadHeaders instance) =>
    <String, dynamic>{
      'Content-Type': instance.contentType,
      'Content-MD5': instance.contentMd5,
    };
