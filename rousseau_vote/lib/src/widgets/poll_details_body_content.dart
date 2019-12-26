import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/widgets/poll_entity_detail.dart';
import 'package:rousseau_vote/src/widgets/poll_text_detail.dart';

class PollDetailsBodyContent extends StatelessWidget {
  const PollDetailsBodyContent(this._poll);

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    final PollStatus pollStatus = _poll.calculatePollStatus();
    final Color statusColor = Poll.getStatusColor[pollStatus];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Text(
            _poll.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            _poll.description,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(children: getOptions())),
        Text(
          'Votazione in corso',
          style: TextStyle(color: statusColor, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  // Widget getOption(int index) {
  //   final Option option = _poll.options[index];
  //   if (_poll.optionType == 'ENTITY') {
  //     return ListTile(title: PollTextDetail(option));
  //   } else {
  //     return ListTile(title: PollEntityDetail(option));
  //   }
  // }

  List<Widget> getOptions() {
    final List<Option> options = _poll.options;
    if (_poll.optionType == 'ENTITY') {
      return options.map((Option o) => PollEntityDetail(o)).toList();
    } else {
      return options.map((Option o) => PollTextDetail(o)).toList();
    }
  }

}


