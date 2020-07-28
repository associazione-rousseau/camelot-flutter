// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ita_geo_division_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItaGeoDivisionList _$ItaGeoDivisionListFromJson(Map<String, dynamic> json) {
  return ItaGeoDivisionList()
    ..italianGeographicalDivisions =
        json['italianGeographicalDivisions'] == null
            ? null
            : ItaGeoDivisionNodes.fromJson(
                json['italianGeographicalDivisions'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ItaGeoDivisionListToJson(ItaGeoDivisionList instance) =>
    <String, dynamic>{
      'italianGeographicalDivisions': instance.italianGeographicalDivisions,
    };
