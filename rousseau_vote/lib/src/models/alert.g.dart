// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) {
  return Alert()
    ..message = json['message'] as String
    ..path = (json['path'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'message': instance.message,
      'path': instance.path,
    };
