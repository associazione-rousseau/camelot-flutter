import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/error_response.dart';
import 'package:rousseau_vote/src/network/response/has_login_response.dart';

part 'credentials_login_response.g.dart';

@JsonSerializable(nullable: true)
class CredentialsLoginResponse with ErrorResponse, HasLoginUrl {
  String loginUrl;
  List<String> errors;

  CredentialsLoginResponse({this.loginUrl, this.errors});

  factory CredentialsLoginResponse.fromJson(Map<String, dynamic> json) => _$CredentialsLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsLoginResponseToJson(this);
}
