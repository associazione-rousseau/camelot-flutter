import 'package:json_annotation/json_annotation.dart';

import 'alert.dart';

part 'poll.g.dart';

@JsonSerializable()
class Poll {

  Poll();

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
  Map<String, dynamic> toJson() => _$PollToJson(this);

  String id;
  String slug;
  String title;
  PollStatus status;
  bool alreadyVoted;
  String description;
  String optionType;
  String resultsLink;
  String announcementLink;
  List<Alert> alerts;
  DateTime showStartingDate;
  DateTime voteStartingDate;
  DateTime voteEndingDate;
}

enum PollStatus { PREVIEW, PUBLISHED, OPEN, CLOSED }
