import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/config/links.dart';
import 'package:rousseau_vote/src/models/entity.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class PollEntityInfoRow extends StatelessWidget {

  PollEntityInfoRow(
    this._active,
    this._entity
  );

  final Entity _entity;
  final bool _active;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[ 
        SizedBox(
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            child:Image.network(_entity.getProfilePictureUrl()),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 15,right:15, top:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[ 
                Text(
                  _entity.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      _entity.profile.age.toString() + ' anni, ' + 
                      (_entity.profile.placeOfResidence != null && _entity.profile.placeOfResidence.comuneName != null ? _entity.profile.placeOfResidence.comuneName : '')
                    ),
                    FlatButton(
                      child: Text(
                        RousseauLocalizations.getText(context, 'view_profile').toUpperCase(),
                        style: TextStyle(
                          color: PRIMARY_RED,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      onPressed: openUrlInternalAction(context, ROUSSEAU_WEB_LINK + 'profiles/' + _entity.slug),
                    ),
                  ],
                )
              ]
            ),
          ),
        ),
        _active ? Padding(
          padding: EdgeInsets.only(right:15, top:15),
          child: Icon(Icons.brightness_1, color: PRIMARY_RED),
          ) : Text(''),
      ]
    );
  }
}
