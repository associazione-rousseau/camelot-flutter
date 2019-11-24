
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingIndicator extends StatelessWidget {
  final Color _color;

  LoadingIndicator(this._color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        backgroundColor: _color,
      ),
    );
  }

}