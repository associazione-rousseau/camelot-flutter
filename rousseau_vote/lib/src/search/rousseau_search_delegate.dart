import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';
import 'package:rousseau_vote/src/widgets/search/suggestion_row.dart';

class RousseauSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    if (query != null || query.isNotEmpty) {
      return <Widget>[];
    }
    return <Widget>[IconButton(
      icon: const Icon(
        Icons.clear,
      ),
      onPressed: () => query = '',
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        color: PRIMARY_RED,
      ),
      onPressed: () {
        close(context, null);
        Provider.of<ActivistsSearchProvider>(context, listen: false).onSearch(context, null);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    if(query == null || query.isEmpty) {
      return;
    }

    close(context, null);

    final SearchSuggestionsProvider provider =
    Provider.of<SearchSuggestionsProvider>(context, listen: false);
    provider.onSearch(query);

    final ActivistsSearchProvider activistsSearchProvider = Provider.of<ActivistsSearchProvider>(context, listen: false);
    activistsSearchProvider.onSearch(context, query);
  }

  @override
  Widget buildResults(BuildContext context) => null; // never executed since we are opening the tab

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query?.isNotEmpty == true) {
      return Container();
    }
    final SearchSuggestionsProvider provider =
        Provider.of<SearchSuggestionsProvider>(context);
    final List<SuggestionType<dynamic>> recentSearches = provider.recentSearches;
    if (recentSearches == null) {
      return Container();
    }

    return Consumer<SearchSuggestionsProvider>(
      builder: (BuildContext context, SearchSuggestionsProvider provider, Widget child) => ListView.builder(
        itemCount: recentSearches.length,
        itemBuilder: (BuildContext buildContext, int position) {
          return SuggestionRow(suggestionType: recentSearches[position]);
        },
      ),
    );
  }
}
