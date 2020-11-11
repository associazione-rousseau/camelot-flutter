// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionsConnection _$OptionsConnectionFromJson(Map<String, dynamic> json) {
  return OptionsConnection()
    ..options = OptionsConnection.sortOptions(json['nodes'] as List)
    ..totalCount = json['totalCount'] as int
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OptionsConnectionToJson(OptionsConnection instance) =>
    <String, dynamic>{
      'nodes': instance.options,
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo,
    };
