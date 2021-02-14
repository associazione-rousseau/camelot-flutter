import 'package:json_annotation/json_annotation.dart';

part 'poll_answer_submit_response.g.dart';

@JsonSerializable()
class PollAnswerSubmitResponse {
  PollAnswerSubmitResponse();

  factory PollAnswerSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$PollAnswerSubmitResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PollAnswerSubmitResponseToJson(this);

  @JsonKey(fromJson: parseErrors, name: 'pollAnswerSubmit')
  List<Object> errors;

  bool get success => errors == null || errors.isEmpty;

  String get errorMessage => errors != null ? errors.first : null;

  bool get alreadyVoted => errorMessage != null && errorMessage == 'Vote already submitted';

  static List<Object> parseErrors(Map<String, dynamic> json) {
    return json != null ? json['errors'] : null;
  }
}
