import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/widgets/user/badge_slider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/widgets/user/poll_entity_info_row.dart';

class PollEntityDetail extends StatelessWidget {

  const PollEntityDetail(
    this._option, 
    this._disabled, 
    this._toggle,
    this._selected,
    this._number,
    this._active
  );

  final Option _option;
  final bool _disabled;
  final Function _toggle;
  final List<Option> _selected;
  final int _number;

  final bool _active;

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
              PollEntityInfoRow(_active, _option.entity),
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
    return !_active && (_disabled || _selected.length >= _number);
  }

  void doSelect() {
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
