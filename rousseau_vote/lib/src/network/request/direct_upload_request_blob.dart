import 'package:json_annotation/json_annotation.dart';

part 'direct_upload_request_blob.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class DirectUploadRequestBlob {

  const DirectUploadRequestBlob({ this.byteSize, this.checksum, this.filename, this.contentType});

  factory DirectUploadRequestBlob.fromJson(Map<String, dynamic> json) =>
      _$DirectUploadRequestBlobFromJson(json);

  Map<String, dynamic> toJson() => _$DirectUploadRequestBlobToJson(this);

  final int byteSize;
  final String checksum;
  final String contentType;
  final String filename;
}