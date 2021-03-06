import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/providers/vote_options_provider.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
import 'package:rousseau_vote/src/widgets/vote/text_option_card.dart';

import 'candidate_option_card.dart';

class PollDetailsBody extends StatelessWidget {
  const PollDetailsBody(this._poll);

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _poll.options.length,
        itemBuilder: (BuildContext context, int index) {
          final Option option = _poll.options[index];
          final VoteOptionsProvider provider =
              Provider.of<VoteOptionsProvider>(context, listen: false);
          final bool selected = provider.isOptionSelected(option);
          if (provider.isCandidatePoll()) {
            final bool visible = provider.isOptionVisible(option);
            return ConditionalWidget(
              child: CandidateOptionCard(option, selected),
              condition: visible,
            );
          } else {
            return TextOptionCard(option, selected);
          }
        });
  }
}
