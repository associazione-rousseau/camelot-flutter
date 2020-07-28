
import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.space);

  final double space;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: space));
  }
  
}