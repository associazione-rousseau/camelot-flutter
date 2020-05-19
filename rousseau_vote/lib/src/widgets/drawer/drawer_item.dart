
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class DrawerItem extends StatelessWidget {

  const DrawerItem({
    @required this.iconData,
    @required this.textKey,
    @required this.onTap
  });

  final IconData iconData;
  final String textKey;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        RousseauLocalizations.getText(context, textKey),
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
      ),
      onTap: () {
        onTap();
        Navigator.pop(context);
      });
    }
}
