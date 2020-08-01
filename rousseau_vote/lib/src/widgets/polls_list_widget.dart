
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';

import 'vote/poll_card.dart';

class PollsListWidget extends StatelessWidget {

  PollsListWidget(PollList list) : _polls = sortedPolls(list);

  final List<Poll> _polls;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        padding: const EdgeInsets.all(10),
        itemCount: _polls.length,
        itemBuilder: (BuildContext context, int index) {
          return PollCard(_polls[index]);
        }
    );
  }

  static List<Poll> sortedPolls(PollList list) {
    final List<Poll> result = <Poll>[];
    result.addAll(list.polls.where((Poll p) => p.pollStatus == PollStatus.OPEN));
    result.addAll(list.polls.where((Poll p) => p.pollStatus == PollStatus.PUBLISHED));
    result.addAll(list.polls.where((Poll p) => p.pollStatus == PollStatus.CLOSED));
    return result;
  }
}