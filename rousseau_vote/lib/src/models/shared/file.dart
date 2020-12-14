import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class File {
  File();

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);

  String originalUrl;
}
