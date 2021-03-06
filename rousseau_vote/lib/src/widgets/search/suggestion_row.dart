import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

class SuggestionRow extends StatelessWidget {
  const SuggestionRow({ @required this.suggestionType, this.dismissible = false });

  final SuggestionType<dynamic> suggestionType;
  final bool dismissible;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          final SearchSuggestionsProvider provider =
          Provider.of<SearchSuggestionsProvider>(context,
              listen: false);
          provider.onSuggestionTapped(suggestionType);
          suggestionType.onTapped(context);
        },
      child: ListTile(
        leading: suggestionType.icon(context),
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        title: suggestionType.title(context),
        subtitle: suggestionType.subtitle(context),
        trailing: dismissible ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                final SearchSuggestionsProvider provider =
                Provider.of<SearchSuggestionsProvider>(context,
                    listen: false);
                provider.onSuggestionRemoved(suggestionType);
              },
            ) : null,
      ),
    );
  }
}
