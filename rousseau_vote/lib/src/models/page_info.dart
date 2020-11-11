import 'package:json_annotation/json_annotation.dart';

part 'page_info.g.dart';

@JsonSerializable()
class PageInfo {
  PageInfo();

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PageInfoToJson(this);

  String endCursor;
  String startCursor;
  bool hasNextPage;
  bool hasPreviousPage;
}