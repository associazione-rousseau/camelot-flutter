import 'package:flutter/widgets.dart';

class RousseauLogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50.0),
          Image(image: AssetImage('assets/images/rousseau_red.png')),
          SizedBox(height: 60.0)
        ]);
  }
}
