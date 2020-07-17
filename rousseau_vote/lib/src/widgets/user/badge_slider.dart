import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';

class BadgeSlider extends StatelessWidget {
  const BadgeSlider({this.badges});
  final List<Badge> badges;
  static const double ICON_SIZE = 40;
  
  @override
  Widget build(BuildContext context) {
    final List<String> badgeImagesPaths = getActiveBadgesImages(badges);

    return SizedBox(
      height: 71,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, left:10,bottom:10),
            child: Text.rich(
             TextSpan(
                text: badgeImagesPaths.length.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n'+RousseauLocalizations.getText(context, 'merits').toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,  
                    ),
                  )
                ]
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 10, left:10),
              itemCount: badgeImagesPaths.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(ICON_SIZE / 2),
                    onTap: () => showMeritMeaning(badgeImagesPaths[index],context),
                    child: Image( 
                      image: AssetImage(badgeImagesPaths[index]),
                      width: ICON_SIZE,
                      height: ICON_SIZE,
                    ),
                  ),
                );
              }
            ),
          ),
        ]
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