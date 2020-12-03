// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paginated<T> _$PaginatedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return Paginated<T>()
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..nodes = (json['nodes'] as List)?.map(fromJsonT)?.toList();
}

Map<String, dynamic> _$PaginatedToJson<T>(
  Paginated<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'pageInfo': instance.pageInfo,
      'nodes': instance.nodes?.map(toJsonT)?.toList(),
    };
