import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

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
    final DateTime now = DateTime.now();
    return now.isAfter(voteStartingDate) && now.isBefore(voteEndingDate);
  }

  bool isScheduled() {
    final DateTime now = DateTime.now();
    return now.isBefore(voteStartingDate);
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

}