import 'package:flutter/material.dart';

/// A screen to display that a loading is in progress.
/// Can have a custom 'message' (defaults to 'Loading')
class LoadingScreen extends StatelessWidget {
  final String message;

  LoadingScreen({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 5,
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                this.message,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
