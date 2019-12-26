import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/widgets/poll_entity_detail.dart';
import 'package:rousseau_vote/src/widgets/poll_text_detail.dart';

class PollDetailsBodyContent extends StatelessWidget {
  const PollDetailsBodyContent(this._poll);

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Text(
            _poll.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            _poll.description,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
        Expanded(child: ListView(children: getOptions())),
        const Divider(),
        // TODO CL show button only for multiple polls
        Padding(
          padding: const EdgeInsets.all(15),
          child: RaisedButton(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                RousseauLocalizations.getText(context, 'vote-button').toUpperCase(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              )
            ),
            color: PRIMARY_RED,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => null,
          )
        ),
        getBottomText(context),
        const SizedBox(height: 20)
      ],
    );
  }

  Text getBottomText(BuildContext context) {
    final PollStatus pollStatus = _poll.calculatePollStatus();
    final Color statusColor = Poll.getStatusColor[pollStatus];
    Color color = statusColor;
    String text;
    if (_poll.alreadyVoted) {
      color = VOTED_BLUE;
      text = 'vote-already-done';
    } else if (pollStatus == PollStatus.OPEN) {
      text = 'poll-open';
    } else if (pollStatus == PollStatus.PUBLISHED) {
      text = 'vote-published';
    }
    return Text(
      RousseauLocalizations.getText(context, text),
      style: TextStyle(color: color, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }

  List<Widget> getOptions() {
    final List<Option> options = _poll.options;
    if (_poll.optionType == 'ENTITY') {
      return options.map((Option o) => PollEntityDetail(o)).toList();
    } else {
      return options.map((Option o) => PollTextDetail(o)).toList();
    }
  }

}


