import 'package:injectable/injectable.dart';

import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

@injectable
class SearchAllSearchHandler implements SearchHandler {

  @override
  Future<List<WordSearchSuggestion>> search(String word) async => <WordSearchSuggestion>[WordSearchSuggestion(word)];
}