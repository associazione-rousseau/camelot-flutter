// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token()
    ..accessToken = json['accessToken'] as String
    ..expiresIn = json['expiresIn'] as int
    ..refreshExpiresIn = json['refreshExpiresIn'] as int
    ..refreshToken = json['refreshToken'] as String
    ..tokenType = json['tokenType'] as String
    ..notBeforePolicy = json['notBeforePolicy'] as int
    ..sessionState = json['sessionState'] as String
    ..scope = json['scope'] as String;
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresIn': instance.expiresIn,
      'refreshExpiresIn': instance.refreshExpiresIn,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'notBeforePolicy': instance.notBeforePolicy,
      'sessionState': instance.sessionState,
      'scope': instance.scope,
    };
