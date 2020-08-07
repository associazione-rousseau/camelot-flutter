import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/direct_upload.dart';

part 'direct_file_upload_response.g.dart';

@JsonSerializable()
class DirectFileUploadResponse {

  DirectFileUploadResponse(this.directUpload);
  DirectUpload directUpload;

  factory DirectFileUploadResponse.fromJson(Map<String, dynamic> json) => _$DirectFileUploadResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DirectFileUploadResponseToJson(this);
}
