import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/widgets/vote_dialog.dart';

class PollTextDetail extends StatelessWidget {

  const PollTextDetail(this._option, this._pollId);

  final String _pollId;
  final Option _option;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5,
      child: InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(
              _option.text,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.justify
            ),
          )
        ),
        onTap: () => doAction(context),
      ),
    );
  }

  void doAction(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return VoteDialog(<Option>[_option], _pollId);
      }
    );
  }

}