import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
import 'package:rousseau_vote/src/widgets/errors/error_page_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/search/suggestion_row.dart';
import 'package:rousseau_vote/src/widgets/search/suggestion_section_widget.dart';

class RousseauSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    if (query != null || query.isNotEmpty) {
      return <Widget>[];
    }
    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () => query = '',
      )
    ];
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
        Provider.of<ActivistsSearchProvider>(context, listen: false)
            .resetState(notify: true);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    if (query == null || query.isEmpty) {
      return;
    }

    final SearchSuggestionsProvider provider =
        Provider.of<SearchSuggestionsProvider>(context, listen: false);
    provider.onSearch(query);
//
//    final ActivistsSearchProvider activistsSearchProvider =
//        Provider.of<ActivistsSearchProvider>(context, listen: false);
//    activistsSearchProvider.onSearch(context, query);
    super.showResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    final SearchSuggestionsProvider provider = Provider.of<SearchSuggestionsProvider>(context);

    final List<SuggestionType<dynamic>>  suggestionTypes = provider.searchResults;
    final ListView suggestionListView = ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: suggestionTypes.length,
      itemBuilder: (BuildContext buildContext, int position) {
        return SuggestionRow(suggestionType: suggestionTypes[position], dismissible: false,);
      },
    );

    return ListView(
      children: <Widget>[
        suggestionListView,
        ConditionalWidget(condition: provider.isLoading, child: const LoadingIndicator()),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query?.isNotEmpty == true) {
      return Container();
    }
    final SearchSuggestionsProvider provider =
        Provider.of<SearchSuggestionsProvider>(context);

    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        const VerticalSpace(10),
        SuggestionSectionWidget(
            suggestionTypes: provider.recentSearches, labelKey: 'recent', dismissible: true,),
        const VerticalSpace(10),
        SuggestionSectionWidget(
            suggestionTypes: provider.geographicalSuggestions,
            labelKey: 'near-you'),
        const VerticalSpace(10),
        SuggestionSectionWidget(
            suggestionTypes: _randomPositionSuggestions(provider.positionSuggestions, SuggestionSectionWidget.DEFAULT_MAX_SIZE),
            maxSize: SuggestionSectionWidget.DEFAULT_MAX_SIZE,
            labelKey: 'roles'),
      ],
    );
  }

  List<SuggestionType<Position>> _randomPositionSuggestions(List<SuggestionType<Position>> positionSuggestions, int size) {
    if (positionSuggestions == null || positionSuggestions.length < size) {
      return positionSuggestions;
    }
    final int startIndex = Random().nextInt(positionSuggestions.length - size - 1);
    return positionSuggestions.sublist(startIndex, startIndex + size);
  }
}
