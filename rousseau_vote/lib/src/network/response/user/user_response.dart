import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/network/response/user/feedback_submit_response.dart';
part 'user_response.g.dart';

@JsonSerializable()

class UserResponse {
  UserResponse();

  FeedbackSubmitResponse userFeedbackSubmit;

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}