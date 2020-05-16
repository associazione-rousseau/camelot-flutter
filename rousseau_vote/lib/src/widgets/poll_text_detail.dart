import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/option.dart';

class PollTextDetail extends StatelessWidget {

  const PollTextDetail(this._option, this._disabled, this._selected);

  final Option _option;
  final bool _disabled;
  final List<Option> _selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      child: InkWell(
        highlightColor: _disabled ? Colors.transparent : null,
        splashColor: _disabled ? Colors.transparent : null,
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(
              _option.text,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.justify
            ),
          )
        ),
        onTap: () => _disabled ? null : doSelect(),
      ),
    );
  }

  void doSelect() {
    if (_selected.contains(_option)) {
      _selected.remove(_option);
    } else {
      _selected.add(_option);
    }
  }

}