import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

part 'municipio.g.dart';

@JsonSerializable()
class Municipio extends ItalianGeographicalDivision {

  Municipio();

  factory Municipio.fromJson(Map<String, dynamic> json) => _$MunicipioFromJson(json);
  Map<String, dynamic> toJson() => _$MunicipioToJson(this);

  @override
  String getType() => 'municipio';
}
