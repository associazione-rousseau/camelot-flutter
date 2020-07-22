import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/user/user_response.dart';
part 'generic_user_response.g.dart';

@JsonSerializable()
class GenericUserResponse {
  GenericUserResponse();
  
  UserResponse user;

  factory GenericUserResponse.fromJson(Map<String, dynamic> json) => _$GenericUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenericUserResponseToJson(this);
}