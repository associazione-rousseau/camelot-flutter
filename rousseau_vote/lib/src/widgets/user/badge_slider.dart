import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/badge.dart';

class BadgeSlider extends StatelessWidget {
  const BadgeSlider({this.badges});
  final List<Badge> badges;
  static const double ICON_SIZE = 40;
  static const Map<String, String> BADGE_ICON_MAPPING = { 
    'list_representative': 'merit_1', 
    'italia_cinque_stelle_volunteer': 'merit_1',
    'villaggio_rousseau_volunteer': 'merit_1',
    'call_to_actions_organizer': 'merit_2',
    'activism_organizer': 'merit_2',
    'sharing_proposer': 'merit_2',
    'user_lex_proposer': 'merit_2',
    'graduate': 'merit_3',
    'english_language_expert': 'merit_4',
    'openday_participant': 'merit_5',
    'villaggio_rousseau_participant': 'merit_5',
    'elearnign_student': 'merit_6',
    'special_mentions': 'merit_7',
    'high_specialization': 'merit_8',
    'community_leader': 'merit_9',
  };

  @override
  Widget build(BuildContext context) {

    final List<String> meritIcons = [];
    for(final Badge badge in badges) {
      final String meritIcon = BADGE_ICON_MAPPING[badge.code];
      if(!meritIcons.contains(meritIcon)) {
        meritIcons.add(meritIcon);
      }
    }

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
              itemCount: meritIcons.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(ICON_SIZE / 2),
                    onTap: () => showMeritMeaning(meritIcons[index],context),
                    child: Image( 
                      image: AssetImage('assets/images/merits/' + meritIcons[index] +  '_true.png'),
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

  void showMeritMeaning(String merit, BuildContext context){
    showDialog<CupertinoAlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            children: <Widget>[
              Image( 
                image: AssetImage('assets/images/merits/' + merit +  '_true.png'),
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
}