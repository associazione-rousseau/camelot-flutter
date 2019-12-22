import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class PollDetailsScreen extends StatelessWidget {
  const PollDetailsScreen(this.pollId);

  static const String ROUTE_NAME = '/polls';

  final String pollId;

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      appBar: RousseauAppBar(),
      body: Column(
        children: <Widget>[
          Text(
            'Poll details: $pollId',
          )
        ],
      ),
    );
  }
}