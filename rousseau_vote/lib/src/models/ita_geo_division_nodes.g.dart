// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ita_geo_division_nodes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItaGeoDivisionNodes _$ItaGeoDivisionNodesFromJson(Map<String, dynamic> json) {
  return ItaGeoDivisionNodes()
    ..nodes = (json['nodes'] as List)
        ?.map((e) => e == null
            ? null
            : ItalianGeographicalDivision.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ItaGeoDivisionNodesToJson(
        ItaGeoDivisionNodes instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
    };
