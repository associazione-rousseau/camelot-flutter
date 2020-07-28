import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/ita_geo_division_nodes.dart';

part 'ita_geo_division_list.g.dart';

@JsonSerializable()
class ItaGeoDivisionList {

  ItaGeoDivisionList();

  factory ItaGeoDivisionList.fromJson(Map<String, dynamic> json) => _$ItaGeoDivisionListFromJson(json);
  Map<String, dynamic> toJson() => _$ItaGeoDivisionListToJson(this);

  ItaGeoDivisionNodes italianGeographicalDivisions;
}