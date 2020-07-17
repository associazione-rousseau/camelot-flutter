import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({this.badgeImagePath, this.iconSize = 40});
  final String badgeImagePath;
  final double iconSize;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(iconSize / 2),
        onTap: () => showMeritMeaning(badgeImagePath,context),
        child: Image( 
          image: AssetImage(badgeImagePath),
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
  void showMeritMeaning(String meritImagePath, BuildContext context){
    int index = meritImagePath.indexOf('merit');
    String meritText = meritImagePath.substring(index,index+6);
    showDialog<CupertinoAlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            children: <Widget>[
              Image( 
                image: AssetImage(meritImagePath),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top:15),
                child: Text(RousseauLocalizations.getText(context, meritText)),
              )
            ],
          ),
        );
      }
    );
  }
}