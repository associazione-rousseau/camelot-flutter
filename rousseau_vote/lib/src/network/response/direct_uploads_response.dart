import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/direct_upload.dart';

part 'direct_uploads_response.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class DirectUploadsResponse {
  DirectUploadsResponse();

  factory DirectUploadsResponse.fromJson(Map<String, dynamic> json) =>
      _$DirectUploadsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DirectUploadsResponseToJson(this);

  double id;
  String key;
  String filename;
  String contentType;
  double byteSize;
  String checksum;
  DateTime createdAt;
  String signedId;
  DirectUpload directUpload;
}
