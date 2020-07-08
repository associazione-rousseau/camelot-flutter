import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/badge.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

class BadgeSlider extends StatelessWidget {
  const BadgeSlider({this.badges});

  final List<Badge> badges;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 71,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8, left:4,bottom:10),
            child: Text.rich(
             TextSpan(
                text: badges.length.toString(),
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
              padding: const EdgeInsets.only(bottom: 10),
              itemCount: badges.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: Chip(
                    label: Text(
                      RousseauLocalizations.getText(context, badges[index].name).toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                );
              }
            ),
          ),
        ]
      ),
    );
  }
}