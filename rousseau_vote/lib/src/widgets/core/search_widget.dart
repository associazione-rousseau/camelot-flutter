
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class SearchWidget extends StatelessWidget {

  const SearchWidget({ @required this.labelTextKey, @required this.hintTextKey, @required this.onSubmitted});

  final ValueChanged<String> onSubmitted;
  final String labelTextKey;
  final String hintTextKey;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          labelText:
          RousseauLocalizations.getText(context, labelTextKey),
          hintText: RousseauLocalizations.getText(
              context, hintTextKey),
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}
