import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/done_dialog.dart';
import 'package:rousseau_vote/src/widgets/error_dialog.dart';
import 'package:rousseau_vote/src/widgets/poll_entity_detail.dart';
import 'package:rousseau_vote/src/widgets/poll_text_detail.dart';
import 'package:rousseau_vote/src/widgets/vote_dialog.dart';

class PollDetailsBodyContent extends StatefulWidget {
  
  const PollDetailsBodyContent(this._poll);

  final Poll _poll;

  @override
  State<StatefulWidget> createState() {
    return _PollDetailsBodyContentState(_poll);
  }

}

class _PollDetailsBodyContentState extends State<PollDetailsBodyContent> {

  _PollDetailsBodyContentState(this._poll);

  final Poll _poll;
  List<Option> selected = <Option>[];

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
        Expanded(
          child: ListView.builder(
            itemCount: _poll.options.length,
            itemBuilder: (BuildContext context, int position) {
              return getOption(position);
            },
          )
        ),
        const SizedBox(height: 10),
        getBottomText(context),
        _poll.alreadyVoted || _poll.calculatePollStatus() == PollStatus.CLOSED  ? Container() : getPreferencesText(context),
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
    } else if (pollStatus == PollStatus.CLOSED) {
      text = 'vote-closed';
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
        color: selected.isEmpty ? DISABLED_GREY : PRIMARY_RED,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () => selected.isEmpty ? showMessage(context) : showAction(context),
      )
    );
  }

  Widget getOption(int index) {
    if (_poll.optionType == 'ENTITY') {
      return PollEntityDetail(
        _poll.options[index],
        _poll.alreadyVoted || selected.length >= _poll.maxSelectableOptionsNumber, 
        _toggle,
        selected,
        _poll.maxSelectableOptionsNumber
      );
    } else {
      return PollTextDetail(
        _poll.options[index],
        _poll.alreadyVoted || selected.length >= _poll.maxSelectableOptionsNumber, 
        _toggle,
        selected,
        _poll.maxSelectableOptionsNumber
      );
    }
  }

  void _toggle(Option option) {
    final List<Option> result = selected;
    if (result.contains(option)) {
      result.remove(option);
    } else {
      result.add(option);
    }
    setState(() { selected = result; });
  }

  void showMessage(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(RousseauLocalizations.getText(context, 'vote-pick-one')),
          action: SnackBarAction(
            label: RousseauLocalizations.getText(context, 'close'),
            onPressed: () => Scaffold.of(context).hideCurrentSnackBar()
          ),
        )
      );
  }

  void showAction(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return VoteDialog(
          selected, 
          _poll.slug,
          showError,
          showDone
        );
      }
    );
  }

  void showDone(BuildContext context) {
    Navigator.of(context).pop();
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return DoneDialog(_endAction);
      }
    );
  }

  void showError(BuildContext context) {
    Navigator.of(context).pop();
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          RousseauLocalizations.getText(context, 'error-vote'),
          _endAction
        );
      }
    );
  }

  void _endAction(BuildContext context) {
    openRoute(
      context, 
      PollsScreen.ROUTE_NAME,
      replace: true
    );
  }

}


