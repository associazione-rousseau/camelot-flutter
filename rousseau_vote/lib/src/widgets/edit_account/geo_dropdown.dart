import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'dart:convert';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class GeoDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> variables = HashMap<String, dynamic>();
    variables.putIfAbsent('type', () => 'COMUNE');
    print('variables:');
    print(jsonEncode(variables));
    return GraphqlQueryWidget<List<ItalianGeographicalDivision>>(
      variables: variables,
      query: italianGeographicalDivisions,
      builderSuccess: (List<ItalianGeographicalDivision> geoDiv) {
        print('ciao');
        return Text('ciao');
      },
      builderLoading: () {
        return const LoadingIndicator();
      },
      builderError: (List<GraphQLError> error) {
        print('error');
        print(error.toString());
                return Text('error');
      },
    );
  }
}
