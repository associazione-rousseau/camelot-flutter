import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/widgets/rousseau_scaffold.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
        body: Column(
          children: <Widget>[
            Text(
              'Login Screen',
            )
          ],
        ),
    );
  }
}