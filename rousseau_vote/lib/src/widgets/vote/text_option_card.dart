import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/providers/vote_options_provider.dart';

class TextOptionCard extends StatelessWidget {
  const TextOptionCard(this._option, this._selected);

  final Option _option;
  final bool _selected;

  static const double DEFAULT_SPACING = 30;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: _selected ? BorderSide(color: PRIMARY_RED, width: 2.0) : BorderSide.none,
          borderRadius: BorderRadius.circular(DEFAULT_SPACING)),
      elevation: 5,
      child: InkWell(
        onTap: () => _onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            title: Text(
              _option.text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Provider.of<VoteOptionsProvider>(context).onOptionSelected(context, _option);
  }
}
