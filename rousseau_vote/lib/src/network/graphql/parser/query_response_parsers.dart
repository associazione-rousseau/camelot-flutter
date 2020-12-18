
import 'package:rousseau_vote/src/models/country_list.dart';
import 'package:rousseau_vote/src/models/geo/countries.dart';
import 'package:rousseau_vote/src/models/geo/italian_geographical_divisions.dart';
import 'package:rousseau_vote/src/models/ita_geo_division_list.dart';
import 'package:rousseau_vote/src/models/poll_detail.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/models/profile/positions.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/graphql/parser/countries_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/country_list_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/ita_geo_divisions_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/poll_detail_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/positions_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/profile_search_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/user_profile_parser.dart';

import 'current_user_parser.dart';
import 'italian_geographical_divisions_parser.dart';
import 'poll_list_parser.dart';

Map<Type, QueryResponseParser<dynamic>> map = <Type, QueryResponseParser<dynamic>>{
  PollList: PollListParser(),
  PollDetail: PollDetailParser(),
  CurrentUser: CurrentUserParser(),
  UserProfile: UserProfileParser(),
  ItaGeoDivisionList: ItaGeoDivisionListParser(),
  CountryList : CountryListParser(),
  ProfileSearch: ProfileSearchParser(),
  Positions: PositionsParser(),
  ItalianGeographicalDivisions: ItalianGeographicalDivisionsParser(),
  Countries: CountriesParser(),
};

QueryResponseParser<T> getParser<T>() {
  return map[T];
}
