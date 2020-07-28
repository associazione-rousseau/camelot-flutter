import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField(
      {this.hintText,
      this.obscureText = false,
      this.enabled = true,
      this.controller,
      this.labelText});

  final String hintText;
  final bool obscureText;
  final bool enabled;
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: labelText != null ? 15.0 : 0),
      child: TextField(
        obscureText: obscureText,
        enabled: enabled,
        controller: controller,
        style: const TextStyle(fontFamily: 'Roboto', fontSize: 20.0),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: hintText,
            labelText: labelText != null ? RousseauLocalizations.of(context).text(labelText) : null,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
    );
  }
}
