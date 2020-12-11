import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

part 'provincia.g.dart';

@JsonSerializable()
class Provincia extends ItalianGeographicalDivision {

  Provincia();

  factory Provincia.fromJson(Map<String, dynamic> json) => _$ProvinciaFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinciaToJson(this);

  @override
  String getType() => 'provincia';
}
