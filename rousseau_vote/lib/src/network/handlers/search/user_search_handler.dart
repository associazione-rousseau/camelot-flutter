import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

@injectable
class UserSearchHandler extends SearchHandler {
  static const int RESULTS_LIMIT = 6;

  @override
  Future<List<SuggestionType<User>>> doSearch(String word) async {
    final Map<String, dynamic> variables = <String, dynamic>{'first': RESULTS_LIMIT, 'fullName': word };
    final GraphqlFetcher<ProfileSearch> graphqlFetcher = GraphqlFetcher<ProfileSearch>(query: profileSearchShort, variables: variables);
    final ProfileSearch result = await graphqlFetcher.fetch();
    final List<SuggestionType<User>> suggestions = <SuggestionType<User>>[];
    final List<User> users = result.profiles.nodes;
    for (User user in users) {
      suggestions.add(ProfileSuggestion(user));
    }
    return suggestions;
  }
}
