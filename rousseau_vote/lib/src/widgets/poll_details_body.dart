import 'package:flutter/widgets.dart';

class PollDetailsBody extends StatelessWidget {
  
  const PollDetailsBody(this.pollId);

  final String pollId;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text(
            'Poll details: $pollId',
          )
        ],
    );
  }
}