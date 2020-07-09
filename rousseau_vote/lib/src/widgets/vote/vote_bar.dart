import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/done_dialog.dart';
import 'package:rousseau_vote/src/widgets/error_dialog.dart';
import 'package:rousseau_vote/src/widgets/vote_dialog.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/option.dart';

class VoteBar extends StatelessWidget {

  final Poll _poll;
  final List<Option> _selected;

  VoteBar(this._poll,this._selected);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getPreferencesBar(context),
        getVoteButton(context)
      ],
    );
  }
  
  Widget getVoteButton(BuildContext context) {
    if (!_poll.isOpen() || _poll.alreadyVoted) {
      return Container();
    }
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: RaisedButton(
        child: Text(
          RousseauLocalizations.getText(context, 'vote-button').toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        color: _selected.isEmpty ? DISABLED_GREY : PRIMARY_RED,
        onPressed: () => _selected.isEmpty ? showMessage(context) : showAction(context),
      ),
    );
  }

  Widget getPreferencesBar(BuildContext context) {
    if(_poll.alreadyVoted || _poll.calculatePollStatus() == PollStatus.CLOSED){
     return Container();
    }

    final int remainingPreferences = _poll.maxSelectableOptionsNumber - _selected.length;
    if(remainingPreferences == 0){
      return Text(
        RousseauLocalizations.getText(context, 'vote-preferences-done'),
        style: const TextStyle(fontSize: 18),
      );
    }
    final String text1 = RousseauLocalizations.getText(context, 'vote-preferences-1');
    String text2 = '';
    if (remainingPreferences == 1) {
      text2 += RousseauLocalizations.getText(context, 'vote-preferences-2s');
    } else {
      text2 += RousseauLocalizations.getText(context, 'vote-preferences-2p');
    }
    return Text.rich(
      TextSpan(
        text: text1,
        style: const TextStyle(fontSize: 18),
        children:<TextSpan>[
          TextSpan(
            text: remainingPreferences.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600
            )
          ),
          TextSpan(
            text: text2
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
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
          _selected, 
          _poll.slug,
          showError,
          showDone,
          _poll.optionType
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
  