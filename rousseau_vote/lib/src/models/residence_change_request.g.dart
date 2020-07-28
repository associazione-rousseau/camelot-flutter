// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_change_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResidenceChangeRequest _$ResidenceChangeRequestFromJson(
    Map<String, dynamic> json) {
  return ResidenceChangeRequest()
    ..status = json['status'] as String
    ..country = json['country'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['country'] as Map<String, dynamic>)
    ..regione = json['regione'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['regione'] as Map<String, dynamic>)
    ..provincia = json['provincia'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['provincia'] as Map<String, dynamic>)
    ..comune = json['comune'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['comune'] as Map<String, dynamic>)
    ..municipio = json['municipio'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['municipio'] as Map<String, dynamic>)
    ..overseaseCity = json['overseaseCity'] as String;
}

Map<String, dynamic> _$ResidenceChangeRequestToJson(
        ResidenceChangeRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
      'country': instance.country,
      'regione': instance.regione,
      'provincia': instance.provincia,
      'comune': instance.comune,
      'municipio': instance.municipio,
      'overseaseCity': instance.overseaseCity,
    };
