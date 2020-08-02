// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_upload_request_blob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectUploadRequestBlob _$DirectUploadRequestBlobFromJson(
    Map<String, dynamic> json) {
  return DirectUploadRequestBlob(
    byteSize: json['byte_size'] as int,
    checksum: json['checksum'] as String,
    filename: json['filename'] as String,
    contentType: json['content_type'] as String,
  );
}

Map<String, dynamic> _$DirectUploadRequestBlobToJson(
        DirectUploadRequestBlob instance) =>
    <String, dynamic>{
      'byte_size': instance.byteSize,
      'checksum': instance.checksum,
      'content_type': instance.contentType,
      'filename': instance.filename,
    };
