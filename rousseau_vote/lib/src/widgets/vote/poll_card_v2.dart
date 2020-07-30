import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/util/dialog_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/horizontal_space.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';

class PollCardV2 extends StatelessWidget {
  const PollCardV2(this._poll);

  final Poll _poll;

  static const Map<PollStatus, IconData> STATUS_ICON_MAPPING =
      <PollStatus, IconData>{
    PollStatus.PUBLISHED: Icons.today,
    PollStatus.OPEN: Icons.offline_bolt,
    PollStatus.CLOSED: Icons.event_available,
  };

  static const double DEFAULT_SPACING = 30;

  @override
  Widget build(BuildContext context) {
    final String startDateString = RousseauLocalizations.getTextFormatted(
        context,
        'poll-start-full',
        <String>[formatDate(context, _poll.voteStartingDate)]);
    final String endDateString = RousseauLocalizations.getTextFormatted(context,
        'poll-end-full', <String>[formatDate(context, _poll.voteEndingDate)]);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DEFAULT_SPACING)),
      elevation: 5,
      child: InkWell(
        onTap: _onCtaTapAction(context),
        child: Padding(
          padding: const EdgeInsets.all(DEFAULT_SPACING),
          child: Column(
            children: <Widget>[
              Text(
                _poll.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const VerticalSpace(10),
              ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(startDateString),
                    Text(endDateString),
                  ],
                ),
                leading: _getIcon(context),
              ),
//            _alreadyVoted(context),
              _buttonBar(context)
            ],
          ),
        ),
      ),
    );
  }

  Function _onCtaTapAction(BuildContext context) {
    return () {
      switch (_poll.pollStatus) {
        case PollStatus.PUBLISHED:
          openPollDetails(context, _poll);
          break;
        case PollStatus.OPEN:
          if (_poll.alreadyVoted) {
            showSimpleSnackbar(context, textKey: 'poll-voted');
          } else if (_poll.canVote) {
            if (_poll.isSupported) {
              openPollDetails(context, _poll);
            } else {
              _showPollNotSupported(context);
            }
          } else {
            showSimpleSnackbar(context, textKey: 'poll-alert');
          }
          break;
        case PollStatus.CLOSED:
          if (_poll.hasResults) {
            final SnackBarAction action = createSnackBarAction(
                context,
                'poll-results',
                openUrlInternalAction(context, _poll.resultsLink));
            showSimpleSnackbar(context, textKey: 'poll-closed', action: action);
          } else {
            showSimpleSnackbar(context, textKey: 'poll-closed-no-results');
          }
          break;
      }
    };
  }

  Widget _alreadyVoted(BuildContext context) {
    if (!_poll.alreadyVoted) {
      return Container();
    }
    final String text = RousseauLocalizations.getText(context, 'poll-voted');
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.done, color: Colors.grey),
          const HorizontalSpace(5),
          Text(
            text,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buttonBar(BuildContext context) {
    final List<Widget> buttons = <Widget>[];
    if (_poll.announcementLink != null) {
      buttons.add(_linkButton(context, 'poll-info', _poll.announcementLink));
    }
    if (_poll.resultsLink != null) {
      buttons.add(
          _linkButton(context, 'poll-results', _poll.resultsLink, bold: true));
    }
    if (_poll.mightVote) {
      buttons.add(_voteButton(context, 'vote-button'));
    } else if (_poll.scheduled) {
      buttons.add(_voteButton(context, 'vote-view'));
    }
    return ButtonBar(
      buttonPadding: const EdgeInsets.only(left: 10, top: 20),
      children: buttons,
    );
  }

  Widget _linkButton(BuildContext context, String textKey, String url,
      {bool bold = false}) {
    return _button(context, textKey, openUrlInternalAction(context, url),
        bold: bold);
  }

  Widget _voteButton(BuildContext context, String textKey) {
    return _button(context, textKey, _onCtaTapAction(context), bold: true);
  }

  Widget _button(BuildContext context, String textKey, Function action,
      {bool bold = false}) {
    final String text =
        RousseauLocalizations.getText(context, textKey).toUpperCase();
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(
            color: _poll.color,
            fontSize: 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
      onPressed: action,
    );
  }

  Icon _getIcon(BuildContext context) {
//    return Icon(STATUS_ICON_MAPPING[_poll.pollStatus],
//        color: _poll.color, size: 40);
    if (_poll.alreadyVoted) {
      return Icon(Icons.event_available, color: _poll.color, size: 40);
    }
    return _poll.open
        ? Icon(Icons.calendar_today, color: _poll.color, size: 35)
        : Icon(Icons.event_busy, color: _poll.color, size: 40);
  }

  void _showPollNotSupported(BuildContext context) {
    showAlertDialog(context,
        titleKey: 'vote-not-supported-title',
        messageKey: 'vote-not-supported-message',
        buttonKey1: 'back',
        buttonKey2: 'vote-not-supported-button',
        buttonAction1: () => Navigator.pop(context),
        buttonAction2: () {
          Navigator.pop(context);
          openUrlExternal(context, _poll.url);
        });
  }
}
