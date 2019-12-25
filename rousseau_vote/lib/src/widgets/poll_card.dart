import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/browser_arguments.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

class PollCard extends StatelessWidget {
  const PollCard(this._poll);

  static const Map<PollStatus, Color> COLOR_MAPPING = <PollStatus, Color>{
    PollStatus.PUBLISHED: PUBLISHED_ORANGE,
    PollStatus.OPEN: OPEN_GREEN,
    PollStatus.CLOSED: CLOSED_RED
  };

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    final PollStatus pollStatus = _poll.calculatePollStatus();
    final Color statusColor = COLOR_MAPPING[pollStatus];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      child: InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.adjust, color: statusColor, size: 50),
                title: Text(
                  _poll.title,
                  textAlign: TextAlign.center,
                ),
                subtitle: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(RousseauLocalizations.getText(context, 'poll-start')),
                        Text(
                          '${UiUtil.formatDate( _poll.voteStartingDate)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(RousseauLocalizations.getText(context, 'poll-end')),
                        Text(
                          '${UiUtil.formatDate(_poll.voteEndingDate)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  getAnnouncementButton(context, statusColor),
                  Text(
                    RousseauLocalizations.getText(context, getActionText(pollStatus)),
                    style: TextStyle(color: statusColor),
                  )
                ],
              )
            ]
          )
        ),
        onTap: () => doAction(context, pollStatus),
      )
    );
  }

  void doAction(BuildContext context, PollStatus status) {
    if (status == PollStatus.PUBLISHED) {
      
    } else if (status == PollStatus.OPEN) {

    } else if (_poll.resultsLink != null) {
      UiUtil.openLink(context, BrowserArguments(url: _poll.resultsLink));
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(RousseauLocalizations.getText(context, 'poll-no-result')),
          action: SnackBarAction(
            label: RousseauLocalizations.getText(context, 'close'),
            onPressed: () => Scaffold.of(context).hideCurrentSnackBar()
          ),
        )
      );
    }
  }

  String getActionText(PollStatus status) {
    if (status == PollStatus.PUBLISHED) {
      return 'poll-published';
    } else if (status == PollStatus.OPEN) {
      return 'poll-open';
    } else if (_poll.resultsLink != null) {
      return 'poll-result';
    } else {
      return 'poll-closed';
    }
  }

  Widget getAnnouncementButton(BuildContext context, Color color) {
    if (_poll.announcementLink != null) {
      return OutlineButton.icon(
        borderSide: BorderSide(color: color),
        textColor: color,
        icon: Icon(Icons.info_outline),
        onPressed: () => UiUtil.openLink(context, BrowserArguments(url: _poll.announcementLink)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        label: Text(RousseauLocalizations.getText(context, 'poll-info')),
      );
    } else {
      return Container();
    }
  }

}