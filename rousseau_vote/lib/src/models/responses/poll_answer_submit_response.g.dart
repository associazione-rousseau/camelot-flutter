// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_answer_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollAnswerSubmitResponse _$PollAnswerSubmitResponseFromJson(
    Map<String, dynamic> json) {
  return PollAnswerSubmitResponse()
    ..errors = PollAnswerSubmitResponse.parseErrors(
        json['pollAnswerSubmit'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PollAnswerSubmitResponseToJson(
        PollAnswerSubmitResponse instance) =>
    <String, dynamic>{
      'pollAnswerSubmit': instance.errors,
    };
