// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericUserResponse _$GenericUserResponseFromJson(Map<String, dynamic> json) {
  return GenericUserResponse()
    ..user = json['user'] == null
        ? null
        : UserResponse.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GenericUserResponseToJson(
        GenericUserResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
