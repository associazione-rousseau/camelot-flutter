import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/alert.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/options_connection.dart';

part 'poll.g.dart';

@JsonSerializable()
class Poll {
  Poll();

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
  Map<String, dynamic> toJson() => _$PollToJson(this);

  static const Map<PollStatus, Color> STATUS_COLOR_MAPPING =
      <PollStatus, Color>{
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
  DateTime createdAt;
  int maxSelectableOptionsNumber;
  List<Alert> alerts;
  OptionsConnection optionsConnection;

  String get currentEndCursor => optionsConnection?.pageInfo?.endCursor;

  List<Option> get options => optionsConnection != null ? optionsConnection.options : null;

  void mergePreviousOptions(List<Option> previousOptions) {
    previousOptions.addAll(optionsConnection.options);
    optionsConnection.options = previousOptions;
  }

  bool get open => status == 'OPEN';
  bool get closed => status == 'CLOSED';
  bool get scheduled => status == 'PUBLISHED';

  PollStatus get pollStatus {
    if (scheduled) {
      return PollStatus.PUBLISHED;
    }
    if (open) {
      return PollStatus.OPEN;
    }
    return PollStatus.CLOSED;
  }

  bool get isCandidatePoll => type == PollType.USER;

  bool get mightVote => open && !alreadyVoted;

  bool get canVote => open && !alreadyVoted && hasRequirements;

  bool get hasRequirements => alerts == null || alerts.isEmpty;

  bool get hasResults => resultsLink != null;
  bool get hasOptions => options != null && options.isNotEmpty;
  bool get isSupported => SUPPORTED_TYPES.contains(type);

  bool get hasNextPage => optionsConnection != null && optionsConnection.pageInfo != null && optionsConnection.pageInfo.hasNextPage;

  bool get isFullyFetched => optionsConnection != null && optionsConnection.totalCount > 0 && optionsConnection.totalCount == options.length;

  String pollEntityType;

  PollType get type {
    switch (pollEntityType) {
      case 'TextOption':
        return PollType.TEXT;
      case 'User':
        return PollType.USER;
      default:
        return PollType.UNKNOWN;
    }
  }

  String get url => '$ROUSSEAU_VOTE_URL/$slug';

  Color get color => STATUS_COLOR_MAPPING[pollStatus];
}

const List<PollType> SUPPORTED_TYPES = <PollType>[
  PollType.TEXT,
  PollType.USER
];

enum PollType { TEXT, USER, UNKNOWN }

enum PollStatus { OPEN, PUBLISHED, CLOSED }
