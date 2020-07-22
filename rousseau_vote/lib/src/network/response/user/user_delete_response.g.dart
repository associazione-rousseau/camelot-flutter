// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDeleteResponse _$UserDeleteResponseFromJson(Map<String, dynamic> json) {
  return UserDeleteResponse()
    ..errors = (json['errors'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$UserDeleteResponseToJson(UserDeleteResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
    };
