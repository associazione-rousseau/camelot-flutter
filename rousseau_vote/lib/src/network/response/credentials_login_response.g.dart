// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialsLoginResponse _$CredentialsLoginResponseFromJson(
    Map<String, dynamic> json) {
  return CredentialsLoginResponse()
    ..errors = (json['errors'] as List)?.map((e) => e as String)?.toList()
    ..loginUrl = json['loginUrl'] as String;
}

Map<String, dynamic> _$CredentialsLoginResponseToJson(
        CredentialsLoginResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'loginUrl': instance.loginUrl,
    };
