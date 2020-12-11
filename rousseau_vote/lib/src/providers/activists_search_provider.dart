import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/lists/filter/search_filter.dart';
import 'package:rousseau_vote/src/lists/filter/toggle_filter.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/interface/generic_list_provider.dart';
import 'package:rousseau_vote/src/screens/activists_screen.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

@injectable
class ActivistsSearchProvider extends GenericListProvider<ProfileSearch, User> {

  ActivistsSearchProvider() {
    onFetcherUpdated(buildFetcher());
  }

  final SearchFilter fullNameSearchFilter = SearchFilter();
  final ToggleFilter badgeFilter = ToggleFilter(BADGES_NUMBER);

  void onBadgeTapped(int badgeNumber) {
    badgeFilter.toggle(badgeNumber);
    notifyListeners();
    onFetcherUpdated(buildFetcher());
  }

  bool isBadgeSelected(int i) => badgeFilter.isActive(i);

  void onSearch(BuildContext context, String fullName) {
    _resetState();
    fullNameSearchFilter.setWord(fullName);
    notifyListeners();

    _maybeOpenActivistsTab(context);

    onFetcherUpdated(buildFetcher());
  }

  void _maybeOpenActivistsTab(BuildContext context) {
    openRoute(context, ActivistsScreen.ROUTE_NAME, replace: true);
  }

  void _resetState() {
    fullNameSearchFilter.reset();
    badgeFilter.reset();
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
