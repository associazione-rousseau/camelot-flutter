import 'dart:collection';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';
import 'package:rousseau_vote/src/models/profile/positions.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

const int MAX_SIZE = 20;

class SearchSuggestionsProvider extends ChangeNotifier {
  SearchSuggestionsProvider(this._searchHandlers) {
    _suggestions = _loadRecentSearches();
    _loadGeographicalSuggestions();
    _loadUserPositionSuggestions();
  }

  final List<SearchHandler> _searchHandlers;

  Queue<SuggestionType<dynamic>> _suggestions;

  bool get isLoading {
    for (CancelableOperation<dynamic> searchOperation in _searchOperations) {
      if (!searchOperation.isCompleted) {
        return true;
      }
    }
    return false;
  }

  List<SuggestionType<dynamic>> get recentSearches => _suggestions.toList();
  List<SuggestionType<ItalianGeographicalDivision>> geographicalSuggestions;
  List<SuggestionType<Position>> positionSuggestions;

  List<SuggestionType<dynamic>> searchResults;
  List<CancelableOperation<dynamic>> _searchOperations;

  void onType(String word) {}

  void onSearch(String word) {
    cancelCurrentSearches();
    searchResults = <SuggestionType<dynamic>>[];
    _searchOperations = <CancelableOperation<dynamic>>[];

    for (SearchHandler searchHandler in _searchHandlers) {
      final CancelableOperation<dynamic> cancelableOperation =
          CancelableOperation<dynamic>.fromFuture(searchHandler.search(word));
      _searchOperations.add(cancelableOperation);
      cancelableOperation.value.then((dynamic suggestions) {
        if (suggestions is List<SuggestionType<dynamic>>) {
          searchResults.addAll(suggestions);
          notifyListeners();
        }
      }).catchError((Object error) {
        print(error);
      });
    }

    notifyListeners();
  }

  void cancelCurrentSearches() {
    if (_searchOperations != null) {
      for (CancelableOperation<dynamic> searchOperation in _searchOperations) {
        searchOperation.cancel();
      }
    }
  }

  void onFullSearch(String word) => _addSuggestion(WordSearchSuggestion(word));

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

  void _loadUserPositionSuggestions() {
    final UserNetworkHandler userNetworkHandler = getIt<UserNetworkHandler>();
    userNetworkHandler
        .fetchAllPositions(fetchPolicy: FetchPolicy.cacheFirst)
        .then((Positions positions) {
      if (positions != null) {
        positionSuggestions = <PositionSuggestion>[];
        for (Position position in positions.positions) {
          positionSuggestions.add(PositionSuggestion(position));
        }
        if (positionSuggestions.isNotEmpty) {
          notifyListeners();
        }
      }
    });
  }

  void _loadGeographicalSuggestions() {
    final UserNetworkHandler userNetworkHandler = getIt<UserNetworkHandler>();
    userNetworkHandler
        .fetchCurrentUser(
            fetchPolicy: FetchPolicy.cacheFirst, fullVersion: false)
        .then((CurrentUser currentUser) {
      if (currentUser != null) {
        geographicalSuggestions = <GeographicalSuggestion>[];
        if (currentUser.country != null &&
            currentUser.country.name != 'Italy') {
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

  void _maybeAddGeographicalSuggestion(
      ItalianGeographicalDivision geographicalDivision) {
    if (geographicalDivision != null) {
      geographicalSuggestions.add(GeographicalSuggestion(geographicalDivision));
    }
  }

  Queue<SuggestionType<dynamic>> _loadRecentSearches() =>
      Queue<SuggestionType<dynamic>>();
}
