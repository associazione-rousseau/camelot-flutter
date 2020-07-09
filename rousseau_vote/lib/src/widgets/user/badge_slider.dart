import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/badge.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

class BadgeSlider extends StatelessWidget {
  const BadgeSlider({this.badges});

  final List<Badge> badges;
  static const double iconSize = 40;
  @override
  Widget build(BuildContext context) {
    final List<String> meritIcons = badgesToMerits();
    return SizedBox(
      height: 71,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, left:10,bottom:10),
            child: Text.rich(
             TextSpan(
                text: meritIcons.length.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\nMeriti'.toUpperCase(),
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
              itemCount: meritIcons.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(iconSize / 2),
                    onTap: () => showMeritMeaning(meritIcons[index],context),
                    child: Image( 
                      image: AssetImage('assets/merits/' + meritIcons[index] +  '_true.png'),
                      width: iconSize,
                      height: iconSize,
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

  void showMeritMeaning(String merit, BuildContext context){
    showDialog<CupertinoAlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            children: <Widget>[
              Image( 
                image: AssetImage('assets/merits/' + merit +  '_true.png'),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top:15),
                child: Text(RousseauLocalizations.getText(context, merit)),
              )
            ],
          ),
        );
      }
    );
  }

  List<String> badgesToMerits(){
    List<String> meritIcons = [];
    if (badges.isNotEmpty){
      for(final badge in badges){
        switch(badge.code) {
          case 'list_representative':
          case 'italia_cinque_stelle_volunteer':
          case 'villaggio_rousseau_volunteer': if(!meritIcons.contains('merit1')) meritIcons.add('merit1'); break;
          case 'call_to_actions_organizer':
          case 'activism_organizer':
          case 'sharing_proposer':
          case 'user_lex_proposer': if(!meritIcons.contains('merit2')) meritIcons.add('merit2'); break; 
          case 'graduate': meritIcons.add('merit3'); break;
          case 'english_language_expert': meritIcons.add('merit4'); break;
          case 'openday_participant':
          case 'villaggio_rousseau_participant': if(!meritIcons.contains('merit5')) meritIcons.add('merit5'); break;
          case 'elearnign_student': meritIcons.add('merit6'); break;
          case 'special_mentions': meritIcons.add('merit7'); break;
          case 'high_specialization': meritIcons.add('merit8'); break;
          case 'community_leader': meritIcons.add('merit9'); break;
        }
      }
    }
    return meritIcons;
  }
}