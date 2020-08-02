// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_upload_headers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectUploadHeaders _$DirectUploadHeadersFromJson(Map<String, dynamic> json) {
  return DirectUploadHeaders()
    ..contentTyoe = json['Content-Type'] as String
    ..contentMd4 = json['Content-MD4'] as String;
}

Map<String, dynamic> _$DirectUploadHeadersToJson(
        DirectUploadHeaders instance) =>
    <String, dynamic>{
      'Content-Type': instance.contentTyoe,
      'Content-MD4': instance.contentMd4,
    };
