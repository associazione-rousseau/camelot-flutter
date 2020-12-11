import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

const int MAX_SIZE = 20;

@injectable
class SearchSuggestionsProvider extends ChangeNotifier {
  SearchSuggestionsProvider() {
    _suggestions = _loadRecentSearches();
  }

  Queue<SuggestionType<dynamic>> _suggestions;
  bool _isLoading;
  bool _hasErrors;

  bool get isLoading => _isLoading;
  bool get hasErrors => _hasErrors;
  List<SuggestionType<dynamic>> get recentSearches => _suggestions.toList();
  List<SuggestionType<dynamic>> get geographicalSuggestions => [GeographicalSuggestion('Nella tua regione')];

  void onType(String word) {}

  void onSearch(String word) => _addSuggestion(WordSearchSuggestion(word));

  void onSuggestionTapped(SuggestionType<dynamic> suggestion) =>
      _addSuggestion(suggestion);

  void onSuggestionRemoved(SuggestionType<dynamic> suggestion) {
    _suggestions.remove(suggestion);
    notifyListeners();
  }

  void onProfileOpened(User user) => _addSuggestion(ProfileSuggestion(user));

  void _addSuggestion(SuggestionType<dynamic> suggestionType) {
    for (SuggestionType<dynamic> currentSuggestion in _suggestions) {
      if (currentSuggestion.suggestion == suggestionType.suggestion) {
        _suggestions.remove(currentSuggestion);
        break;
      }
    }
    if (_suggestions.length == MAX_SIZE) {
      _suggestions.removeLast();
    }
    _suggestions.addFirst(suggestionType);
    notifyListeners();
  }

  Queue<SuggestionType<dynamic>> _loadRecentSearches() =>
      Queue<SuggestionType<dynamic>>();
}