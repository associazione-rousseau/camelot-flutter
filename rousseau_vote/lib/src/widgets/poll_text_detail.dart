import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/option.dart';

import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class PollTextDetail extends StatefulWidget {
  
  const PollTextDetail(
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
    return _PollTextDetailState(_option, _disabled, _toggle, _selected, _number);
  }

}

class _PollTextDetailState extends State<PollTextDetail> {
  
  _PollTextDetailState(this._option, this._disabled, this._toggle, this._selected, this._number);

  final Option _option;
  final bool _disabled;
  final Function _toggle;
  final List<Option> _selected;
  final int _number;

  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      child: InkWell(
        highlightColor: isDisabled() ? Colors.transparent : null,
        splashColor: isDisabled() ? Colors.transparent : null,
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(
              _option.text,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            trailing: active ? Icon(Icons.brightness_1, color: PRIMARY_RED) : null
          )
        ),
        onTap: () => isDisabled() ? showMessage(context) : doSelect(),
      ),
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