import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  int notBeforePolicy;
  String sessionState;
  String scope;

  Token();

  bool isValid() {
    return _isValidSignature() && !isExpired();
  }

  bool isExpired() {
    // TODO implement
    return false;
  }

  bool _isValidSignature() {
    // TODO implement
    return true;
  }

  factory Token.fromTokenResponse(TokenResponse tokenResponse) {
    return Token()
        ..accessToken = tokenResponse.accessToken
      ..expiresIn = tokenResponse.expiresIn
      ..refreshExpiresIn = tokenResponse.refreshExpiresIn
      ..tokenType = tokenResponse.tokenType
      ..notBeforePolicy = tokenResponse.notBeforePolicy
      ..sessionState = tokenResponse.sessionState
      ..scope = tokenResponse.scope;
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}