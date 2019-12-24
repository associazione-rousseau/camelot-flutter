import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
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
          padding: const EdgeInsets.all(15),
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
              _poll.announcementLink != null
              ? OutlineButton.icon(
                  borderSide: BorderSide(color: statusColor),
                  textColor: statusColor,
                  icon: Icon(Icons.info_outline),
                  onPressed: () => null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  label: Text(RousseauLocalizations.getText(context, 'poll-info')),
                )
              : Container()
            ]
          )
        ),
        onTap: () => null,
      )
          // ButtonBarTheme(
          //   data: const ButtonBarThemeData(alignment: MainAxisAlignment.end),
          //   child: ButtonBar(
          //     children: <Widget>[
          //       _poll.announcementLink != null
          //           ? LinkFlatButton(
          //                 color: statusColor,
          //                 textKey: 'cta-info',
          //                 url: _poll.announcementLink
          //             )
          //           : null,
          //       _poll.resultsLink != null
          //           ? LinkFlatButton(
          //               color: statusColor,
          //               textKey: 'cta-results',
          //               url: _poll.resultsLink
          //             )
          //           : null,
          //        _poll.userCanVote()
          //           ? FlatButton(
          //               child: Text(
          //                   RousseauLocalizations.getText(context, 'cta-vote'),
          //                   style: TextStyle(fontWeight: FontWeight.bold, color: statusColor)),
          //               onPressed: () {/* ... */},
          //             )
          //           : null,
          //       pollStatus == PollStatus.PUBLISHED
          //           ? FlatButton(
          //               child: Text(
          //                   RousseauLocalizations.getText(
          //                       context, 'cta-visualize'),
          //                   style: TextStyle(fontWeight: FontWeight.bold, color: statusColor)),
          //               onPressed: () {/* ... */},
          //             )
          //           : null,
          //     ],
          //   ),
          // )
        // ],
      // ),
      
    );
  }
}
