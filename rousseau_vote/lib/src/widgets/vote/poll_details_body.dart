
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/widgets/vote/text_option_card.dart';

import 'candidate_option_card.dart';

class PollDetailsBody extends StatelessWidget {
  const PollDetailsBody(this._poll);

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _poll.options.length,
        itemBuilder: (BuildContext context, int index) {
          final Option option = _poll.options[index];
          if(_poll.type == PollType.CANDIDATE) {
            return CandidateOptionCard(option);
          } else {
            return TextOptionCard(option);
          }
        }
    );
  }
}