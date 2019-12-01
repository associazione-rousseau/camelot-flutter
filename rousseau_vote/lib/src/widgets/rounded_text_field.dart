import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {

  const RoundedTextField(
      {this.hintText,
        this.obscureText = false,
        this.enabled = true,
        this.controller});

  final String hintText;
  final bool obscureText;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      enabled: enabled,
      controller: controller,
      style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}
