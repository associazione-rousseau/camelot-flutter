class Poll {

  String id;
  String slug;
  String title;
  PollStatus status;
  bool alreadyVoted;
  DateTime voteStartinDate;
  DateTime voteEndingDate;

}

enum PollStatus { PREVIEW, PUBLISHED, OPEN, CLOSED }
