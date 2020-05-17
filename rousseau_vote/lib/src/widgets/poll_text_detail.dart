import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/option.dart';

import '../config/app_constants.dart';

class PollTextDetail extends StatefulWidget {
  
  const PollTextDetail(this._option, this._disabled, this._selected, this._number);

  final Option _option;
  final bool _disabled;
  final List<Option> _selected;
  final int _number;

  @override
  State<StatefulWidget> createState() {
    return _PollTextDetailState(_option, _disabled, _selected, _number);
  }

}

class _PollTextDetailState extends State<PollTextDetail> {
  
  _PollTextDetailState(this._option, this._disabled, this._selected, this._number);

  final Option _option;
  final bool _disabled;
  final List<Option> _selected;
  final int _number;

  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      color: active ? ACCENT_RED : Colors.white,
      child: InkWell(
        highlightColor: isDisabled() ? Colors.transparent : null,
        splashColor: isDisabled() ? Colors.transparent : null,
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(
              _option.text,
              style: TextStyle(
                fontSize: 14,
                color: active ? Colors.white : Colors.black
              ),
              textAlign: TextAlign.justify
            ),
          )
        ),
        onTap: () => isDisabled() ? null : doSelect(),
      ),
    );
  }

  bool isDisabled() {
    return _disabled || _selected.length >= _number && !active;
  }

  void doSelect() {
    setState(() { active = !active; });
    if (active) {
      _selected.add(_option);
    } else {
      _selected.remove(_option);
    }
  }

}