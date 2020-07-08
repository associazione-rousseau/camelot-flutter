// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_of_residence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOfResidence _$PlaceOfResidenceFromJson(Map<String, dynamic> json) {
  return PlaceOfResidence()
    ..comuneName = json['comuneName'] as String
    ..provinciaName = json['provinciaName'] as String;
}

Map<String, dynamic> _$PlaceOfResidenceToJson(PlaceOfResidence instance) =>
    <String, dynamic>{
      'comuneName': instance.comuneName,
      'provinciaName': instance.provinciaName,
    };
