
import 'package:rousseau_vote/src/search/suggestion_types.dart';

abstract class SearchHandler {
  Future<List<SuggestionType<dynamic>>> search(String word);
}
