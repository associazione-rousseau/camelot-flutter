import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/alert.dart';
import 'package:rousseau_vote/src/models/option.dart';

part 'poll.g.dart';

@JsonSerializable()
class Poll {

  Poll();

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
  Map<String, dynamic> toJson() => _$PollToJson(this);

  static const Map<PollStatus, Color> getStatusColor = <PollStatus, Color>{
    PollStatus.PUBLISHED: PUBLISHED_ORANGE,
    PollStatus.OPEN: OPEN_GREEN,
    PollStatus.CLOSED: CLOSED_RED
  };

  String id;
  String slug;
  String title;
  String description;
  String status;
  bool alreadyVoted;
  String resultsLink;
  String optionType;
  String announcementLink;
  DateTime showStartingDate;
  DateTime voteStartingDate;
  DateTime voteEndingDate;
  int maxSelectableOptionsNumber;
  List<Alert> alerts;
  List<Option> options;

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