import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Image image = Image(image: AssetImage('assets/images/rousseau_white.png'));
    return Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: image,
            ),
          ],
        ));
  }
}
