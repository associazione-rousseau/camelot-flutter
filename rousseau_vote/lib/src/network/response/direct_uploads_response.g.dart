// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_uploads_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectUploadsResponse _$DirectUploadsResponseFromJson(
    Map<String, dynamic> json) {
  return DirectUploadsResponse()
    ..id = (json['id'] as num)?.toDouble()
    ..key = json['key'] as String
    ..filename = json['filename'] as String
    ..contentType = json['content_type'] as String
    ..byteSize = (json['byte_size'] as num)?.toDouble()
    ..checksum = json['checksum'] as String
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String)
    ..signedId = json['signed_id'] as String
    ..directUpload = json['direct_upload'] == null
        ? null
        : DirectUpload.fromJson(json['direct_upload'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DirectUploadsResponseToJson(
        DirectUploadsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'filename': instance.filename,
      'content_type': instance.contentType,
      'byte_size': instance.byteSize,
      'checksum': instance.checksum,
      'created_at': instance.createdAt?.toIso8601String(),
      'signed_id': instance.signedId,
      'direct_upload': instance.directUpload,
    };
