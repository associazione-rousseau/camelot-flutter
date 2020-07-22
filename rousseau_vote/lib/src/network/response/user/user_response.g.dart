// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse()
    ..userDelete = json['userDelete'] == null
        ? null
        : UserDeleteResponse.fromJson(
            json['userDelete'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'userDelete': instance.userDelete,
    };
