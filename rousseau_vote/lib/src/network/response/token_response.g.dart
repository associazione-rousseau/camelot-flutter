// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return TokenResponse(
    accessToken: json['access_token'] as String,
    error: json['error'] as String,
    errorDescription: json['error_description'] as String,
  )
    ..errors = (json['errors'] as List)?.map((e) => e as String)?.toList()
    ..expiresIn = json['expires_in'] as int
    ..refreshExpiresIn = json['refresh_expires_in'] as int
    ..refreshToken = json['refresh_token'] as String
    ..tokenType = json['token_type'] as String
    ..notBeforePolicy = json['not-before-policy'] as int
    ..sessionState = json['session_state'] as String
    ..scope = json['scope'] as String;
}

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'refresh_expires_in': instance.refreshExpiresIn,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'not-before-policy': instance.notBeforePolicy,
      'session_state': instance.sessionState,
      'scope': instance.scope,
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
