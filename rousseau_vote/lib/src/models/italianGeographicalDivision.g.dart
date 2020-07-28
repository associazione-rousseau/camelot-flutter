// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'italianGeographicalDivision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItalianGeographicalDivision _$ItalianGeographicalDivisionFromJson(
    Map<String, dynamic> json) {
  return ItalianGeographicalDivision(
    json['id'] as String,
    json['name'] as String,
    json['code'] as String,
    json['type'] as String,
    (json['descendants'] as List)
        ?.map((e) => e == null
            ? null
            : ItalianGeographicalDivision.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItalianGeographicalDivisionToJson(
        ItalianGeographicalDivision instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'type': instance.type,
      'descendants': instance.descendants,
    };
