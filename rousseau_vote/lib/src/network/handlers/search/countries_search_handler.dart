import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/geo/countries.dart';
import 'package:rousseau_vote/src/models/geo/country.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

@injectable
class CountriesSearchHandler implements SearchHandler {
  static const int RESULTS_LIMIT = 3;

  @override
  Future<List<SuggestionType<ItalianGeographicalDivision>>> search(String word) async {
    final Map<String, dynamic> variables = <String, dynamic>{'first': RESULTS_LIMIT, 'search': word };
    final GraphqlFetcher<Countries> graphqlFetcher = GraphqlFetcher<Countries>(query: countrySearch, variables: variables);
    final Countries result = await graphqlFetcher.fetch();
    final List<SuggestionType<ItalianGeographicalDivision>> suggestions = <SuggestionType<ItalianGeographicalDivision>>[];
    final List<Country> countries = result.countriesConnection.nodes;
    for (Country country in countries) {
      suggestions.add(GeographicalSuggestion(country));
    }
    return suggestions;
  }
}
