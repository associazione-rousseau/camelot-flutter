import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/widget/horizontal_space.dart';

class RousseauMenuItem extends StatelessWidget {
  const RousseauMenuItem({Key key, @required this.iconData, @required this.textKey})
      : super(key: key);

  final IconData iconData;
  final String textKey;

  @override
  Widget build(BuildContext context) {
    final String text = RousseauLocalizations.getText(context, textKey);
    return Row(children: <Widget>[
      Icon(
        iconData,
        color: Colors.grey,
      ),
      const HorizontalSpace(10),
      Text(text)
    ]);
  }
}

enum RousseauMenuItemType { SHARE, COPY_LINK, OPEN_IN_BROWSER }
