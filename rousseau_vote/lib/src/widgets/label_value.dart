import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';

class LabelValue extends StatelessWidget {
  LabelValue(this._controller, this.label, this._enabled);

  final TextEditingController _controller;
  final String label;
  final bool _enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          RoundedTextField(
            enabled: _enabled,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
