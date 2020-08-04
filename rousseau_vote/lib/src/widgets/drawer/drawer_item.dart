
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class DrawerItem extends StatelessWidget {

  const DrawerItem({
    @required this.iconData,
    @required this.textKey,
    @required this.onTap,
    this.color,
  });

  final IconData iconData;
  final String textKey;
  final GestureTapCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: color,),
      title: Text(
        RousseauLocalizations.getText(context, textKey),
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: color),
      ),
      dense: true,
      onTap: () {
        Navigator.pop(context);
        onTap();
      });
    }
}
