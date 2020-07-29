import 'package:json_annotation/json_annotation.dart';

part 'direct_upload.g.dart';

@JsonSerializable()
class DirectUpload {

  DirectUpload(this.url,this.headers);
  
  factory DirectUpload.fromJson(Map<String, dynamic> json) => _$DirectUploadFromJson(json);
  Map<String, dynamic> toJson() => _$DirectUploadToJson(this);

  String url;
  Map<String,String> headers;
}