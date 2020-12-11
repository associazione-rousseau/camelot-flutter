import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

part 'regione.g.dart';

@JsonSerializable()
class Regione extends ItalianGeographicalDivision {

  Regione();

  factory Regione.fromJson(Map<String, dynamic> json) => _$RegioneFromJson(json);
  Map<String, dynamic> toJson() => _$RegioneToJson(this);

  @override
  String getType() => 'regione';
}
