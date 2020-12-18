import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/geo/italian_geographical_divisions.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

@injectable
class GeographicalSearchHandler implements SearchHandler {
  static const int RESULTS_LIMIT = 3;

  @override
  Future<List<SuggestionType<ItalianGeographicalDivision>>> search(String word) async {
    final Map<String, dynamic> variables = <String, dynamic>{'first': RESULTS_LIMIT, 'search': word };
    final GraphqlFetcher<ItalianGeographicalDivisions> graphqlFetcher = GraphqlFetcher<ItalianGeographicalDivisions>(query: italianGeographicalDivisionsSearch, variables: variables);
    final ItalianGeographicalDivisions result = await graphqlFetcher.fetch();
    final List<SuggestionType<ItalianGeographicalDivision>> suggestions = <SuggestionType<ItalianGeographicalDivision>>[];
    final List<ItalianGeographicalDivision> geographicalDivisions = result.italianGeographicalDivisions.nodes;
    for (ItalianGeographicalDivision geographicalDivision in geographicalDivisions) {
      suggestions.add(GeographicalSuggestion(geographicalDivision));
    }
    return suggestions;
  }
}
