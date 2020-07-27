// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse()
    ..userFeedbackSubmit = json['userFeedbackSubmit'] == null
        ? null
        : FeedbackSubmitResponse.fromJson(
            json['userFeedbackSubmit'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'userFeedbackSubmit': instance.userFeedbackSubmit,
    };
