// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackSubmitResponse _$FeedbackSubmitResponseFromJson(
    Map<String, dynamic> json) {
  return FeedbackSubmitResponse()
    ..errors = (json['errors'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$FeedbackSubmitResponseToJson(
        FeedbackSubmitResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
    };
