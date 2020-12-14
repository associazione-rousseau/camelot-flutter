// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tirendiconto_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TirendicontoData _$TirendicontoDataFromJson(Map<String, dynamic> json) {
  return TirendicontoData()
    ..value = json['value'] as String
    ..isOk = json['isOk'] as bool
    ..lastMonth = json['lastMonth'] as String;
}

Map<String, dynamic> _$TirendicontoDataToJson(TirendicontoData instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isOk': instance.isOk,
      'lastMonth': instance.lastMonth,
    };
