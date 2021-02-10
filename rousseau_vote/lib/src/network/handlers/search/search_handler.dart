
import 'package:rousseau_vote/src/search/suggestion_types.dart';

abstract class SearchHandler {

  List<SuggestionType<dynamic>> lastSearch;
  bool isLoading = false;

  Future<List<SuggestionType<dynamic>>> search(String word) async {
    isLoading = true;
    lastSearch = null;
    try {
      lastSearch = await doSearch(word);
    } catch (_) {
      rethrow;
    } finally {
      isLoading = false;
    }
    return lastSearch;
  }

  Future<List<SuggestionType<dynamic>>> doSearch(String word);
}
