import 'package:json_annotation/json_annotation.dart';
part 'user_delete_response.g.dart';

@JsonSerializable()

class UserDeleteResponse {
  UserDeleteResponse();
  
  List<String> errors;

  factory UserDeleteResponse.fromJson(Map<String, dynamic> json) => _$UserDeleteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserDeleteResponseToJson(this);
}