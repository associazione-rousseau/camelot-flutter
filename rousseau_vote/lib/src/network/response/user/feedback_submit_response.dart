import 'package:json_annotation/json_annotation.dart';
part 'feedback_submit_response.g.dart';

@JsonSerializable()

class FeedbackSubmitResponse {
  FeedbackSubmitResponse();

  List<String> errors;

  factory FeedbackSubmitResponse.fromJson(Map<String, dynamic> json) => _$FeedbackSubmitResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackSubmitResponseToJson(this);
}