import 'package:injectable/injectable.dart';

import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

@injectable
class SearchAllSearchHandler extends SearchHandler {

  @override
  Future<List<WordSearchSuggestion>> doSearch(String word) async => <WordSearchSuggestion>[WordSearchSuggestion(word)];
}