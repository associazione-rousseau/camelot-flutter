import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/error_response.dart';
import 'package:rousseau_vote/src/network/response/has_login_response.dart';

part 'init_login_response.g.dart';

@JsonSerializable(nullable: true)
class InitLoginResponse with ErrorResponse, HasLoginUrl {
  String registerUrl;
  String forgotPasswordUrl;
  String loginUrl;
  List<String> errors;

  InitLoginResponse({this.loginUrl, this.registerUrl, this.forgotPasswordUrl, this.errors});

  factory InitLoginResponse.fromJson(Map<String, dynamic> json) => _$InitLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InitLoginResponseToJson(this);
}
