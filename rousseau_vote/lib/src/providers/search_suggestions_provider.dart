import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

const int MAX_SIZE = 20;

@injectable
class SearchSuggestionsProvider extends ChangeNotifier {
  SearchSuggestionsProvider() {
    _suggestions = _loadRecentSearches();
    _loadGeographicalSuggestions();
  }

  Queue<SuggestionType<dynamic>> _suggestions;
  bool _isLoading;
  bool _hasErrors;

  bool get isLoading => _isLoading;
  bool get hasErrors => _hasErrors;
  List<SuggestionType<dynamic>> get recentSearches => _suggestions.toList();
  List<SuggestionType<ItalianGeographicalDivision>> geographicalSuggestions;

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

  void _loadGeographicalSuggestions() {
    final UserNetworkHandler userNetworkHandler = getIt<UserNetworkHandler>();
    userNetworkHandler.fetchCurrentUser(fetchPolicy: FetchPolicy.cacheOnly, fullVersion: false).then((CurrentUser currentUser) {
      if (currentUser != null) {
        geographicalSuggestions = <GeographicalSuggestion>[];
        if(currentUser.country != null && currentUser.country.name != 'Italy') {
          _maybeAddGeographicalSuggestion(currentUser.country);
        }
        _maybeAddGeographicalSuggestion(currentUser.regione);
        _maybeAddGeographicalSuggestion(currentUser.provincia);
        _maybeAddGeographicalSuggestion(currentUser.comune);
        _maybeAddGeographicalSuggestion(currentUser.municipio);

        notifyListeners();
      }
    });
  }

  void _maybeAddGeographicalSuggestion(ItalianGeographicalDivision geographicalDivision) {
    if (geographicalDivision != null) {
      geographicalSuggestions.add(GeographicalSuggestion(geographicalDivision));
    }
  }

  Queue<SuggestionType<dynamic>> _loadRecentSearches() =>
      Queue<SuggestionType<dynamic>>();
}
