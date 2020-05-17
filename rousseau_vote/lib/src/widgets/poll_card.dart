import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/browser_arguments.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_detail_arguments.dart';
import 'package:rousseau_vote/src/screens/poll_details_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

class PollCard extends StatelessWidget {
  const PollCard(this._poll);

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    final PollStatus pollStatus = _poll.calculatePollStatus();
    final Color statusColor = Poll.getStatusColor[pollStatus];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      child: InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                _poll.title, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              ListTile(
                leading: Icon(Icons.adjust, color: statusColor, size: 40),
                title: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(RousseauLocalizations.getText(context, 'poll-start')),
                            Text(RousseauLocalizations.getText(context, 'poll-end')),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: <Widget>[
                            Text('${UiUtil.formatDate(context,  _poll.voteStartingDate)}'),
                            Text('${UiUtil.formatDate(context, _poll.voteEndingDate)}')
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  getAnnouncementButton(context, statusColor),
                  Text(
                    RousseauLocalizations.getText(context, getActionText(pollStatus)),
                    style: TextStyle(color: statusColor),
                  )
                ],
              ),
              _poll.alreadyVoted ? Text(
                RousseauLocalizations.getText(context, 'poll-voted'),
                style: const TextStyle(color: VOTED_BLUE),
              ) : Container()
            ]
          )
        ),
        onTap: () => doAction(context, pollStatus),
      )
    );
  }

  void doAction(BuildContext context, PollStatus status) {
    if (_poll.alerts != null && _poll.alerts.isNotEmpty) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(RousseauLocalizations.getText(context, 'poll-alert')),
          action: SnackBarAction(
            label: RousseauLocalizations.getText(context, 'close'),
            onPressed: () => Scaffold.of(context).hideCurrentSnackBar()
          ),
        )
      );
    } else if (status == PollStatus.PUBLISHED || status == PollStatus.OPEN) {
      UiUtil.openRoute(
        context, 
        PollDetailsScreen.ROUTE_NAME, 
        PollDetailArguments( _poll.slug, true)
      );
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