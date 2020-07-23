import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/user/residence_request_create_response.dart';
import 'package:rousseau_vote/src/network/response/user/user_delete_response.dart';
part 'user_response.g.dart';

@JsonSerializable()

class UserResponse {
  UserResponse();

  UserDeleteResponse userDelete;
  ResidenceRequestCreateResponse residenceChangeRequestCreate;

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}