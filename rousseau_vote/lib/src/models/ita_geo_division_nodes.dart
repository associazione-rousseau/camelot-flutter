import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

part 'ita_geo_division_nodes.g.dart';

@JsonSerializable()
class ItaGeoDivisionNodes {

  ItaGeoDivisionNodes();

  factory ItaGeoDivisionNodes.fromJson(Map<String, dynamic> json) => _$ItaGeoDivisionNodesFromJson(json);
  Map<String, dynamic> toJson() => _$ItaGeoDivisionNodesToJson(this);

  List<ItalianGeographicalDivision> nodes;
}