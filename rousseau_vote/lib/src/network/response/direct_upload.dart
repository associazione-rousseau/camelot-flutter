import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/direct_upload_headers.dart';

part 'direct_upload.g.dart';

@JsonSerializable(nullable: true)
class DirectUpload {
  DirectUpload();

  factory DirectUpload.fromJson(Map<String, dynamic> json) =>
      _$DirectUploadFromJson(json);

  Map<String, dynamic> toJson() => _$DirectUploadToJson(this);

  String url;
  DirectUploadHeaders headers;
}
