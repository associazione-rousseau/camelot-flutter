import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';
import 'package:rousseau_vote/src/widgets/search/suggestion_row.dart';

class SuggestionSectionWidget extends StatelessWidget {
  const SuggestionSectionWidget(
      {@required this.suggestionTypes,
      @required this.labelKey,
        this.dismissible = false,
      this.maxSize = DEFAULT_MAX_SIZE});

  static const int DEFAULT_MAX_SIZE = 4;

  final List<SuggestionType<dynamic>> suggestionTypes;
  final String labelKey;
  final int maxSize;
  final bool dismissible;

  @override
  Widget build(BuildContext context) {
    if (suggestionTypes == null || suggestionTypes.isEmpty) {
      return Container();
    }
    return Consumer<SearchSuggestionsProvider>(
      builder: (BuildContext context, SearchSuggestionsProvider provider,
              Widget child) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              RousseauLocalizations.getText(context, labelKey),
              textAlign: TextAlign.left,
              style: const TextStyle(color: PRIMARY_RED),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: min(suggestionTypes.length, maxSize),
            itemBuilder: (BuildContext buildContext, int position) {
              return SuggestionRow(suggestionType: suggestionTypes[position], dismissible: dismissible,);
            },
          ),
        ],
      ),
    );
  }
}
