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
  int maxSelectableOptionsNumber;
  List<Alert> alerts;
  @JsonKey(fromJson: sortOptions)
  List<Option> options;

  bool get open => status == 'OPEN';
  bool get closed => status == 'CLOSED';
  bool get scheduled => status == 'PUBLISHED';

  static List<Option> sortOptions(List optionsJson) {
    final List<Option> options = optionsJson
        ?.map((e) =>
            e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        ?.toList();
    if (options != null &&
        options.isNotEmpty &&
        options[0].isEntityUserType) {
      options.sort((Option a, Option b) {
        return b.entity.meritCount - a.entity.meritCount;
      });
    }
    return options;
  }

  PollStatus get pollStatus {
    if (scheduled) {
      return PollStatus.PUBLISHED;
    }
    if (open) {
      return PollStatus.OPEN;
    }
    return PollStatus.CLOSED;
  }

  bool get isCandidatePoll => type == PollType.CANDIDATE;

  bool get mightVote => open && !alreadyVoted;

  bool get canVote => open && !alreadyVoted && hasRequirements;

  bool get hasRequirements =>
      options != null &&
      options.isNotEmpty &&
      (alerts == null || alerts.isEmpty);

  bool get hasResults => resultsLink != null;
  bool get hasOptions => options != null && options.isNotEmpty;
  bool get isSupported => SUPPORTED_TYPES.contains(type);

  PollType get type {
    if (!hasOptions) {
      return PollType.UNKNOWN;
    }
    switch (options[0].type) {
      case 'TextOption':
        return PollType.TEXT;
      case 'EntityOption':
        return options[0].entity.type == 'User'
            ? PollType.CANDIDATE
            : PollType.UNKNOWN;
      default:
        return PollType.UNKNOWN;
    }
  }

  String get url => '$ROUSSEAU_VOTE_URL/$slug';

  Color get color => STATUS_COLOR_MAPPING[pollStatus];
}

const List<PollType> SUPPORTED_TYPES = <PollType>[
  PollType.TEXT,
  PollType.CANDIDATE
];

enum PollType { TEXT, CANDIDATE, UNKNOWN }

enum PollStatus { PUBLISHED, OPEN, CLOSED }
