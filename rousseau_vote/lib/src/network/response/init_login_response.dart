import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/error_response.dart';
import 'package:rousseau_vote/src/network/response/has_login_response.dart';

part 'init_login_response.g.dart';

@JsonSerializable(nullable: true)
class InitLoginResponse with ErrorResponse, HasLoginUrl {

  InitLoginResponse({String responseLoginUrl, this.registerUrl, this.forgotPasswordUrl, List<String> responseErrors}) {
    loginUrl = responseLoginUrl;
    errors = responseErrors;
  }

  factory InitLoginResponse.fromJson(Map<String, dynamic> json) => _$InitLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InitLoginResponseToJson(this);

  String registerUrl;
  String forgotPasswordUrl;
}
