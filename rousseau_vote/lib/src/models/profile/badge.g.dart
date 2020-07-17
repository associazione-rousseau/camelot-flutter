// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(Map<String, dynamic> json) {
  return Badge()
    ..code = json['code'] as String
    ..active = json['active'] as bool;
}

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'code': instance.code,
      'active': instance.active,
    };
