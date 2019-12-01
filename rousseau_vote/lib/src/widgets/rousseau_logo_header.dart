import 'package:flutter/widgets.dart';

class RousseauLogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50.0),
          Image(image: const AssetImage('assets/images/rousseau_red.png')),
          const SizedBox(height: 60.0)
        ]);
  }
}
