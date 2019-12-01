// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitLoginResponse _$InitLoginResponseFromJson(Map<String, dynamic> json) {
  return InitLoginResponse(
    registerUrl: json['registerUrl'] as String,
    forgotPasswordUrl: json['forgotPasswordUrl'] as String,
  )
    ..errors = (json['errors'] as List)?.map((e) => e as String)?.toList()
    ..loginUrl = json['loginUrl'] as String;
}

Map<String, dynamic> _$InitLoginResponseToJson(InitLoginResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'loginUrl': instance.loginUrl,
      'registerUrl': instance.registerUrl,
      'forgotPasswordUrl': instance.forgotPasswordUrl,
    };
