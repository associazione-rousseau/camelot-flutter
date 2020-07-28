import 'package:flutter/material.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.space);

  final double space;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: space));
  }

}