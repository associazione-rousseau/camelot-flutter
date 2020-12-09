import 'package:rousseau_vote/src/lists/filter/search_filter.dart';
import 'package:rousseau_vote/src/lists/filter/toggle_filter.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/interface/generic_list_provider.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';

class ActivistsSearchProvider extends GenericListProvider<ProfileSearch, User> {

  ActivistsSearchProvider() : super(fetcher: GraphqlFetcher<ProfileSearch>(query: profileSearch));

  final SearchFilter fullNameSearchFilter = SearchFilter();
  final ToggleFilter badgeFilter = ToggleFilter(BADGES_NUMBER);

  void onBadgeTapped(int badgeNumber) {
    badgeFilter.toggle(badgeNumber);
    notifyListeners();
    onFetcherUpdated(buildFetcher());
  }

  bool isBadgeSelected(int i) => badgeFilter.isActive(i);

  void onSearch(String fullName) {
    fullNameSearchFilter.setWord(fullName.toLowerCase());
    notifyListeners();
    onFetcherUpdated(buildFetcher());
  }

  Map<String, dynamic> getQueryVariables() {
    final Map<String, dynamic> variables = <String, dynamic>{};

    final String fullName = fullNameSearchFilter.getWord();
    if (fullName != null && fullName.isNotEmpty) {
      variables['fullName'] = fullName;
    }

    if (badgeFilter.hasActives) {
      variables['badges'] = getActiveBadgeNames(badgeFilter.values);
    }

    return variables;
  }

  GraphqlFetcher<ProfileSearch> buildFetcher() => GraphqlFetcher<ProfileSearch>(query: profileSearch, variables: getQueryVariables());
}
