
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/option.dart';

class TextOptionCard extends StatelessWidget {

  const TextOptionCard(this._option);

  final Option _option;

  @override
  Widget build(BuildContext context) {
    return Text(_option.text);
  }

}