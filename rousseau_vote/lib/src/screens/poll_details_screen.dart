import 'package:flutter/widgets.dart';

class PollDetailsScreen extends StatelessWidget {
  static const routeName = '/polls';

  final String pollId;
  const PollDetailsScreen(this.pollId);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Poll details Screen',
        )
      ],
    );
  }
}