
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/providers/vote_options_provider.dart';

class TextOptionCard extends StatelessWidget {

  const TextOptionCard(this._option, this._selected);

  final Option _option;
  final bool _selected;

  @override
  Widget build(BuildContext context) {
    return Text(_option.text);
  }

  void _onTap(BuildContext context) {
    Provider.of<VoteOptionsProvider>(context).onOptionSelected(context, _option);
  }
}