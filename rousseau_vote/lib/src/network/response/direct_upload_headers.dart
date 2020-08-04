import 'package:json_annotation/json_annotation.dart';

part 'direct_upload_headers.g.dart';

@JsonSerializable(nullable: true)
class DirectUploadHeaders {

  DirectUploadHeaders();

  factory DirectUploadHeaders.fromJson(Map<String, dynamic> json) =>
      _$DirectUploadHeadersFromJson(json);

  Map<String, dynamic> toJson() => _$DirectUploadHeadersToJson(this);

  @JsonKey(name: 'Content-Type')
  String contentType;
  @JsonKey(name: 'Content-MD5')
  String contentMd5;
}
