import 'package:rousseau_vote/src/models/poll_option.dart';

class Poll {

  String id;
  String slug;
  String title;
  PollStatus status;
  bool alreadyVoted;
  DateTime voteStartinDate;
  DateTime voteEndingDate;

  List<PollOption> options;

}

enum PollStatus { PREVIEW, PUBLISHED, OPEN, CLOSED }
