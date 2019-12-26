import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/alert.dart';

part 'poll.g.dart';

@JsonSerializable()
class Poll {

  Poll();

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
  Map<String, dynamic> toJson() => _$PollToJson(this);

  String id;
  String slug;
  String title;
  String description;
  String status;
  bool alreadyVoted;
  String resultsLink;
  String announcementLink;
  DateTime showStartingDate;
  DateTime voteStartingDate;
  DateTime voteEndingDate;
  List<Alert> alerts;

  bool isOpen() {
    final DateTime now = DateTime.now();
    return now.isAfter(voteStartingDate) && now.isBefore(voteEndingDate);
  }

  bool isScheduled() {
    final DateTime now = DateTime.now();
    return now.isBefore(voteStartingDate);
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