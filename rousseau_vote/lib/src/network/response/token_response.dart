import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/error_response.dart';

part 'token_response.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class TokenResponse with ErrorResponse {

  TokenResponse();

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  @JsonKey(name: 'not-before-policy')
  int notBeforePolicy;
  String sessionState;
  String scope;

  String error;
  String errorDescription;

  @override
  bool hasErrors() {
    return error != null;
  }
}