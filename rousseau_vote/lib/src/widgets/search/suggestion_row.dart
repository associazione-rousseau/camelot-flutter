import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';

class SuggestionRow extends StatelessWidget {
  const SuggestionRow({@required this.suggestionType});

  final SuggestionType<dynamic> suggestionType;

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
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              suggestionType.icon(context),
              suggestionType.body(context),
            ],
          ),
          const Spacer(),
          ConditionalWidget(
              condition: suggestionType.dismissible(),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  final SearchSuggestionsProvider provider =
                      Provider.of<SearchSuggestionsProvider>(context,
                          listen: false);
                  provider.onSuggestionRemoved(suggestionType);
                },
              ))
        ],
      ),
    );
  }
}
