import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

part 'comune.g.dart';

@JsonSerializable()
class Comune extends ItalianGeographicalDivision {

  Comune();

  factory Comune.fromJson(Map<String, dynamic> json) => _$ComuneFromJson(json);
  Map<String, dynamic> toJson() => _$ComuneToJson(this);

  @override
  String getType() => 'comune';
}
