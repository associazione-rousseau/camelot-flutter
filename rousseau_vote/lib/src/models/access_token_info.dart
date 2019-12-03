import 'dart:convert';

import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:json_annotation/json_annotation.dart';

part 'access_token_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, nullable: true)
class AccessTokenInfo {

  AccessTokenInfo();

  factory AccessTokenInfo.fromAccessToken(String accessToken) {
    final String payload = accessToken.split('.')[1];
    final String jsonString = B64urlEncRfc7515.decodeUtf8(payload);
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    return AccessTokenInfo.fromJson(jsonMap);
  }

  factory AccessTokenInfo.fromJson(Map<String, dynamic> json) => _$AccessTokenInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenInfoToJson(this);

  String jti;
  int exp;
  int nbf;
  int iat;
  String iss;
  List<String> aud;
  String sub;
  String typ;
  String azp;
  String nonce;
  int authTime;
  String sessionState;
  String acr;
  Map<String, dynamic> resourceAccess;
  String scope;
  bool emailVerified;
  String gender;
  String name;
  String preferredUsername;
  String givenName;
  String familyName;
  String email;

  bool isExpired() {
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000).isBefore(DateTime.now());
  }
}
