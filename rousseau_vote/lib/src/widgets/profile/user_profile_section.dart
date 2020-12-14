import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection(this._titleKey, this._text);

  final String _titleKey;
  final String _text;

  @override
  Widget build(BuildContext context) {
    if (_text == null || _text.isEmpty) {
      return Container();
    }
    final String title = RousseauLocalizations.of(context).text(_titleKey);
    return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: Column(children: <Widget>[
          Card(
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15),
                  child: Column(children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Divider(
                      color: Colors.black38,
                    ),
                    Html(data: _text),
                  ]))),
        ]));
  }
}
