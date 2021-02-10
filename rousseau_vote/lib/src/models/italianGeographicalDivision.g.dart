// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'italianGeographicalDivision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItalianGeographicalDivision _$ItalianGeographicalDivisionFromJson(
    Map<String, dynamic> json) {
  return ItalianGeographicalDivision()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..code = json['code'] as String
    ..type = json['type'] as String
    ..descendants = (json['descendants'] as List)
        ?.map((e) => e == null
            ? null
            : ItalianGeographicalDivision.fromJson(e as Map<String, dynamic>))
        ?.toList();
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
