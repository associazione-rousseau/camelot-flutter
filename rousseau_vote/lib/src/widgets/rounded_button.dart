import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class RoundedButton extends StatelessWidget {
  final text;
  final onPressed;
  final loading;

  RoundedButton({this.text, this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: loading ? null : onPressed,
        child: loading ? LoadingIndicator(Colors.white) : _buttonTextWidget(text),
      ),
    );
  }

  static Widget _buttonTextWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
