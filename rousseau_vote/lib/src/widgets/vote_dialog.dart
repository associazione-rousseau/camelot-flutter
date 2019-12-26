import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';

class VoteDialog extends StatelessWidget {

  const VoteDialog(this._options);

  final List<Option> _options;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      title: Text(
        RousseauLocalizations.getText(context, 'vote-confirm'),
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: getContent(context),
      elevation: 5,
      actions: <Widget>[
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'cancel'),
            style: const TextStyle(fontSize: 18),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop()
        ),
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'confirm'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => null
        ),
        Container()
      ],
    );
  }

  Widget getContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(RousseauLocalizations.getText(
          context, 
          _options.length == 1 ? 'vote-content-1s' : 'vote-content-1p'
        )),
        const SizedBox(height: 10),
        for(Option option in _options) Row(children: <Widget>[
          const SizedBox(width: 10),
          Icon(Icons.radio_button_checked),
          const SizedBox(width: 10),
          Text(option.text, style: const TextStyle(fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 10),
        Text(RousseauLocalizations.getText(context, 'vote-content-2'))
      ],
    );
  }

}