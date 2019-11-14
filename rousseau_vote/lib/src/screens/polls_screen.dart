import 'package:flutter/widgets.dart';

import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class PollsScreen extends StatelessWidget {
  
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      Column(
        children: <Widget>[
          Text(
            'Polls Screen',
          )
        ],
      ),
    );
  }
}