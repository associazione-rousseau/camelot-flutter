import 'package:json_annotation/json_annotation.dart';

part 'tirendiconto_data.g.dart';

@JsonSerializable()
class TirendicontoData {
  TirendicontoData();

  factory TirendicontoData.fromJson(Map<String, dynamic> json) =>
      _$TirendicontoDataFromJson(json);
  Map<String, dynamic> toJson() => _$TirendicontoDataToJson(this);

  String value;
  bool isOk;
  String lastMonth;
}
