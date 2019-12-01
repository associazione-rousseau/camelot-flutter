import 'package:flutter/widgets.dart';

import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class PollsScreen extends StatelessWidget {
  
  static const String ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      Column(
        children: const <Widget>[
          Text(
            'Polls Screen',
          )
        ],
      ),
    );
  }

}