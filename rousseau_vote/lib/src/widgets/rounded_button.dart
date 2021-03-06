import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class RoundedButton extends StatelessWidget {

  const RoundedButton({this.text, this.onPressed, this.loading = false, this.wrapContent = false});

  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final bool wrapContent;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: onPressed != null ? Theme.of(context).primaryColor : DISABLED_GREY,
      child: MaterialButton(
        minWidth: wrapContent ? 0 : MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: loading ? null : onPressed,
        child: loading ? LoadingIndicator(color: Colors.white) : _buttonTextWidget(text),
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
