
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingIndicator extends StatelessWidget {

  const LoadingIndicator(this._color);

  final Color _color;

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