// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialsLoginResponse _$CredentialsLoginResponseFromJson(
    Map<String, dynamic> json) {
  return CredentialsLoginResponse(
    loginUrl: json['loginUrl'] as String,
    errors: (json['errors'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CredentialsLoginResponseToJson(
        CredentialsLoginResponse instance) =>
    <String, dynamic>{
      'loginUrl': instance.loginUrl,
      'errors': instance.errors,
    };
