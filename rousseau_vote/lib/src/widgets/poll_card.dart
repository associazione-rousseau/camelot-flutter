import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

import 'link_flat_button.dart';

class PollCard extends StatelessWidget {
  const PollCard(this._poll);

  static const Map<String, Color> COLOR_MAPPING = <String, Color>{
    PUBLISHED: PUBLISHED_ORANGE,
    OPEN: OPEN_GREEN,
    CLOSED: CLOSED_RED
  };

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = COLOR_MAPPING[_poll.status];
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 0.5, color: statusColor)),
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 30,
              decoration: BoxDecoration(
                color: statusColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15))),
              //color: statusColor,
              child: const ListTile()),
          ListTile(
            contentPadding: const EdgeInsets.only(top: 15.0, left: 15.0),
            leading: _getBadge(_poll.status),
            title: Text(_poll.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Text('Inizio: ${UiUtil.formatDate(_poll.voteStartingDate)}'),
                Text('Fine: ${UiUtil.formatDate(_poll.voteEndingDate)}'),
              ],
            ),
          ),
          ButtonBarTheme(
            data: const ButtonBarThemeData(alignment: MainAxisAlignment.end),
            child: ButtonBar(
              children: <Widget>[
                _poll.announcementLink != null
                    ? LinkFlatButton(
                          color: statusColor,
                          textKey: 'cta-info',
                          url: _poll.announcementLink
                      )
                    : null,
                _poll.resultsLink != null
                    ? LinkFlatButton(
                        color: statusColor,
                        textKey: 'cta-results',
                        url: _poll.resultsLink
                      )
                    : null,
                 _poll.userCanVote()
                    ? FlatButton(
                        child: Text(
                            RousseauLocalizations.getText(context, 'cta-vote'),
                            style: TextStyle(fontWeight: FontWeight.bold, color: statusColor)),
                        onPressed: () {/* ... */},
                      )
                    : null,
                _poll.status == PUBLISHED
                    ? FlatButton(
                        child: Text(
                            RousseauLocalizations.getText(
                                context, 'cta-visualize'),
                            style: TextStyle(fontWeight: FontWeight.bold, color: statusColor)),
                        onPressed: () {/* ... */},
                      )
                    : null,
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getBadge(String pollStatus) {
    final Color color = COLOR_MAPPING[pollStatus];
    if (_poll.alreadyVoted) {
      return Icon(Icons.check_circle, color: color);
    }
    if (pollStatus == PUBLISHED) {
      return Icon(Icons.event, color: color);
    }
    if (pollStatus == OPEN) {
      return Icon(Icons.offline_bolt, color: Colors.green);
    }
    return Icon(Icons.error_outline, color: color);
  }
}
