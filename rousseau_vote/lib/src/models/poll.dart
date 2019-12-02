import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/poll_option.dart';

@JsonSerializable()
class Poll {

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

  List<PollOption> options;

}

enum PollStatus { PREVIEW, PUBLISHED, OPEN, CLOSED }
