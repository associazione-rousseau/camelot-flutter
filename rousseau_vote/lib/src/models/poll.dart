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
  String status;
  bool alreadyVoted;
  String description;
  String optionType;
  String resultsLink;
  String announcementLink;
  List<Alert> alerts;
  DateTime showStartingDate;
  DateTime voteStartingDate;
  DateTime voteEndingDate;

  bool isOpen() {
    return status == 'OPEN';
  }

  bool isScheduled() {
    return status == 'PUBLISHED';
  }

  bool userCanVote() {
    return userHasVotingRights() && isOpen();
  }

  bool userHasVotingRights() {
    return alerts == null || alerts.isEmpty;
  }

  PollStatus calculatePollStatus() {
    if (isScheduled()) {
      return PollStatus.PUBLISHED;
    }
    if (isOpen()) {
      return PollStatus.OPEN;
    }
    return PollStatus.CLOSED;
  }
}

enum PollStatus { PUBLISHED, OPEN, CLOSED }