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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            _poll.description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(child: ListView(children: getOptions())),
        const SizedBox(height: 10),
        getBottomText(context),
        _poll.alreadyVoted ? Container() : getPreferencesText(context),
        getVoteButton(context),
        const SizedBox(height: 10),
      ],
    );
  }

  Text getPreferencesText(BuildContext context) {
    String text = RousseauLocalizations.getText(context, 'vote-preferences-1') + _poll.maxSelectableOptionsNumber.toString();
    if (_poll.maxSelectableOptionsNumber == 1) {
      text += RousseauLocalizations.getText(context, 'vote-preferences-2s');
    } else {
      text += RousseauLocalizations.getText(context, 'vote-preferences-2p');
    }

    return Text(
      text,
      style: const TextStyle(fontSize: 12, color: Colors.redAccent),
      textAlign: TextAlign.center,
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
      style: TextStyle(color: color, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  Widget getVoteButton(BuildContext context) {
    if (!_poll.isOpen() || _poll.alreadyVoted) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(5),
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
    );
  }

  List<Widget> getOptions() {
    final List<Option> options = _poll.options;
    if (_poll.optionType == 'ENTITY') {
      return options.map((Option o) => PollEntityDetail(o, _poll.slug, _poll.alreadyVoted)).toList();
    } else {
      return options.map((Option o) => PollTextDetail(o, _poll.slug, _poll.alreadyVoted)).toList();
    }
  }

}


