import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/widgets/user/badge_slider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/config/links.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class PollEntityDetail extends StatefulWidget {

  const PollEntityDetail(
    this._option, 
    this._disabled, 
    this._toggle,
    this._selected,
    this._number
  );

  final Option _option;
  final bool _disabled;
  final Function _toggle;
  final List<Option> _selected;
  final int _number;

  @override
  State<StatefulWidget> createState() {
    return _PollEntityDetailState(_option, _disabled, _toggle, _selected, _number);
  }

}

class _PollEntityDetailState extends State<PollEntityDetail> {

  _PollEntityDetailState(this._option, this._disabled, this._toggle, this._selected, this._number);

  final Option _option;
  final bool _disabled;
  final Function _toggle;
  final List<Option> _selected;
  final int _number;

  bool active = false;

  @override
  Widget build(BuildContext context) {
    print(_option.entity.fullName);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      child: InkWell(
        highlightColor: isDisabled() ? Colors.transparent : null,
        splashColor: isDisabled() ? Colors.transparent : null,
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ 
                  SizedBox(
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      child:Image.network(_option.entity.getProfilePictureUrl()),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right:15, top:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[ 
                          Text(
                            _option.entity.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                _option.entity.profile.age.toString() + ' anni, ' + 
                                (_option.entity.profile.placeOfResidence != null && _option.entity.profile.placeOfResidence.comuneName != null ? _option.entity.profile.placeOfResidence.comuneName : '')
                              ),
                              FlatButton(
                                child: Text(
                                  RousseauLocalizations.getText(context, 'view_profile').toUpperCase(),
                                  style: TextStyle(
                                    color: PRIMARY_RED,
                                    fontWeight: FontWeight.w600
                                  )
                                ),
                                onPressed: openUrlInternalAction(context, ROUSSEAU_WEB_LINK + 'profiles/' + _option.entity.slug),
                              ),
                            ],
                          )
                        ]
                      ),
                    ),
                  ),
                  active ? Padding(
                    padding: EdgeInsets.only(right:15, top:15),
                    child: Icon(Icons.brightness_1, color: PRIMARY_RED),
                    ) : Text(''),
                ]
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: BadgeSlider(badges: _option.entity.badges)
              )
            ],
          ),
        onTap: () => isDisabled() ? showMessage(context) : doSelect(),
      )
    );
  }

  bool isDisabled() {
    return !active && (_disabled || _selected.length >= _number);
  }

  void doSelect() {
    setState(() { active = !active; });
    _toggle(_option);
  }

  void showMessage(BuildContext context) {
    String text = '';
    if (_disabled) {
      text = 'vote-already';
    } else {
      text = 'vote-limit';
    }
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(RousseauLocalizations.getText(context, text)),
          action: SnackBarAction(
            label: RousseauLocalizations.getText(context, 'close'),
            onPressed: () => Scaffold.of(context).hideCurrentSnackBar()
          ),
        )
      );
  }

}
