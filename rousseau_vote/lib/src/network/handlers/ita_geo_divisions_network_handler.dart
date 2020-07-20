
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/country_list.dart';
import 'package:rousseau_vote/src/models/ita_geo_division_list.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';

@singleton
class ItaGeoDivisionsNetworkHandler {

  ItaGeoDivisionsNetworkHandler(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  Future<ItaGeoDivisionList> getGeoDivList(String type, String search, String parentType, String parentCode) async {
    Map<String, String> geoVar = {
      'type': type.toLowerCase(),
      'search': search
    };
    if(parentCode.isNotEmpty){
      geoVar.putIfAbsent('parentType', () => parentType);
      geoVar.putIfAbsent('parentCode', () => parentCode);
    }

    final QueryOptions queryOptions = QueryOptions(
      documentNode: gql(italianGeographicalDivisions),
      variables: geoVar
    );
    final QueryResult result = await _graphQLClient.query(queryOptions);
    return getParser<ItaGeoDivisionList>().parse(result);
  }

  Future<List<ItalianGeographicalDivision>> getCountries(String search) async {
    final QueryOptions queryOptions = QueryOptions(
      documentNode: gql(countries),
    );
    final QueryResult result = await _graphQLClient.query(queryOptions);
    final CountryList countryList =  getParser<CountryList>().parse(result);
    final List<ItalianGeographicalDivision> filteredCountries =  countryList.countries.where((ItalianGeographicalDivision c) => c.name.toLowerCase().contains(search.toLowerCase())).toList();
    return filteredCountries;
  }

}