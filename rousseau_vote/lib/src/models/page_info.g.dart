// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) {
  return PageInfo()
    ..endCursor = json['endCursor'] as String
    ..startCursor = json['startCursor'] as String
    ..hasNextPage = json['hasNextPage'] as bool
    ..hasPreviousPage = json['hasPreviousPage'] as bool;
}

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      'endCursor': instance.endCursor,
      'startCursor': instance.startCursor,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };
