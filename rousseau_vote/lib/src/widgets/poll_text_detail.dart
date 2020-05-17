import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/option.dart';

import '../config/app_constants.dart';
import '../models/option.dart';

class PollTextDetail extends StatefulWidget {
  
  const PollTextDetail(this._option, this._disabled, this._toggle);

  final Option _option;
  final bool _disabled;
  final Function _toggle;

  @override
  State<StatefulWidget> createState() {
    return _PollTextDetailState(_option, _disabled, _toggle);
  }

}

class _PollTextDetailState extends State<PollTextDetail> {
  
  _PollTextDetailState(this._option, this._disabled, this._toggle);

  final Option _option;
  final bool _disabled;
  final Function _toggle;

  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      color: active ? ACCENT_RED : Colors.white,
      child: InkWell(
        highlightColor: _isDisabled() ? Colors.transparent : null,
        splashColor: _isDisabled() ? Colors.transparent : null,
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
        onTap: () => _isDisabled() ? null : doSelect(),
      ),
    );
  }

  bool _isDisabled() {
    return _disabled && !active;
  }

  void doSelect() {
    setState(() { active = !active; });
    _toggle(_option);
  }

}