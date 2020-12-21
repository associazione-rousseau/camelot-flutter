import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/lists/filter/geographical_filter.dart';
import 'package:rousseau_vote/src/lists/filter/position_filter.dart';
import 'package:rousseau_vote/src/lists/filter/search_filter.dart';
import 'package:rousseau_vote/src/lists/filter/toggle_filter.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';
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
  final GeographicalFilter geographicalFilter = GeographicalFilter();
  final PositionFilter positionFilter = PositionFilter();

  void onBadgeTapped(int badgeNumber) {
    badgeFilter.toggle(badgeNumber);
    notifyListeners();
    onFetcherUpdated(buildFetcher());
  }

  bool isBadgeSelected(int i) => badgeFilter.isActive(i);

  void onSearch(BuildContext context, String fullName) {
    resetState();
    fullNameSearchFilter.setWord(fullName);
    notifyListeners();

    _maybeOpenActivistsTab(context);

    onFetcherUpdated(buildFetcher());
  }

  void onSearchByGeographicalDivision(
      BuildContext context, ItalianGeographicalDivision geographicalDivision) {
    resetState();
    geographicalFilter.geographicalDivision = geographicalDivision;
    notifyListeners();

    _maybeOpenActivistsTab(context);

    onFetcherUpdated(buildFetcher());
  }

  void onSearchByPosition(BuildContext context, Position position) {
    resetState();
    positionFilter.position = position;
    notifyListeners();

    _maybeOpenActivistsTab(context);

    onFetcherUpdated(buildFetcher());
  }

  void _maybeOpenActivistsTab(BuildContext context) {
    openRoute(context, ActivistsScreen.ROUTE_NAME, replace: true);
  }

  bool get filtersSet =>
      fullNameSearchFilter.isSet ||
      badgeFilter.hasActives ||
      geographicalFilter.isSet ||
      positionFilter.isSet;

  void resetState({bool notify = false}) {
    fullNameSearchFilter.reset();
    badgeFilter.reset();
    geographicalFilter.reset();
    positionFilter.reset();
    if (notify) {
      notifyListeners();
    }
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

    if (geographicalFilter.isSet) {
      if (geographicalFilter.isCountry) {
        variables['countryCode'] = geographicalFilter.geographicalCode;
      } else {
        variables['italianGeographicalDivisionCode'] =
            geographicalFilter.geographicalCode;
        variables['italianGeographicalDivisionType'] =
            geographicalFilter.geographicalType;
      }
    }

    if (positionFilter.isSet) {
      variables['positionCodes'] = positionFilter.positionCodes;
    }

    return variables;
  }

  GraphqlFetcher<ProfileSearch> buildFetcher() => GraphqlFetcher<ProfileSearch>(
      query: profileSearch, variables: getQueryVariables());
}
