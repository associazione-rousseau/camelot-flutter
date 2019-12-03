// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenInfo _$AccessTokenInfoFromJson(Map<String, dynamic> json) {
  return AccessTokenInfo()
    ..jti = json['jti'] as String
    ..exp = json['exp'] as int
    ..nbf = json['nbf'] as int
    ..iat = json['iat'] as int
    ..iss = json['iss'] as String
    ..aud = (json['aud'] as List)?.map((e) => e as String)?.toList()
    ..sub = json['sub'] as String
    ..typ = json['typ'] as String
    ..azp = json['azp'] as String
    ..nonce = json['nonce'] as String
    ..authTime = json['auth_time'] as int
    ..sessionState = json['session_state'] as String
    ..acr = json['acr'] as String
    ..resourceAccess = json['resource_access'] as Map<String, dynamic>
    ..scope = json['scope'] as String
    ..emailVerified = json['email_verified'] as bool
    ..gender = json['gender'] as String
    ..name = json['name'] as String
    ..preferredUsername = json['preferred_username'] as String
    ..givenName = json['given_name'] as String
    ..familyName = json['family_name'] as String
    ..email = json['email'] as String;
}

Map<String, dynamic> _$AccessTokenInfoToJson(AccessTokenInfo instance) =>
    <String, dynamic>{
      'jti': instance.jti,
      'exp': instance.exp,
      'nbf': instance.nbf,
      'iat': instance.iat,
      'iss': instance.iss,
      'aud': instance.aud,
      'sub': instance.sub,
      'typ': instance.typ,
      'azp': instance.azp,
      'nonce': instance.nonce,
      'auth_time': instance.authTime,
      'session_state': instance.sessionState,
      'acr': instance.acr,
      'resource_access': instance.resourceAccess,
      'scope': instance.scope,
      'email_verified': instance.emailVerified,
      'gender': instance.gender,
      'name': instance.name,
      'preferred_username': instance.preferredUsername,
      'given_name': instance.givenName,
      'family_name': instance.familyName,
      'email': instance.email,
    };
