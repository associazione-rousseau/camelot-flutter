// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_file_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectFileUploadResponse _$DirectFileUploadResponseFromJson(
    Map<String, dynamic> json) {
  return DirectFileUploadResponse(
    json['directUpload'] == null
        ? null
        : DirectUpload.fromJson(json['directUpload'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DirectFileUploadResponseToJson(
        DirectFileUploadResponse instance) =>
    <String, dynamic>{
      'directUpload': instance.directUpload,
    };
