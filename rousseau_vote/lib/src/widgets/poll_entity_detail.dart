import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/option.dart';

class PollEntityDetail extends StatelessWidget {

  const PollEntityDetail(this._option, this._pollId, this._disabled);

  final String _pollId;
  final Option _option;
  final bool _disabled;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}