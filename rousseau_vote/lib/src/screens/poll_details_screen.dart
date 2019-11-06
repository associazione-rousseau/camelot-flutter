import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class PollDetailsScreen extends StatelessWidget {
  final String pollId;
  const PollDetailsScreen(this.pollId);

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      Column(
        children: <Widget>[
          Text(
            'Poll details: $pollId',
          )
        ],
      ),
    );
  }
}