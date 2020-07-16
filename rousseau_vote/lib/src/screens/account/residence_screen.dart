import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rousseau_vote/src/network/handlers/ita_geo_divisions_network_handler.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';

class ResidenceScreen extends StatelessWidget {
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();

  ItaGeoDivisionsNetworkHandler itaGeoDivisionsNetworkHandler = getIt<ItaGeoDivisionsNetworkHandler>();
  TextEditingController _countryTextController;
  TextEditingController _regioneTextController;
  TextEditingController _provinciaTextController;
  TextEditingController _comuneTextController;
  TextEditingController _municipioTextController;

  static const String ROUTE_NAME = '/account_residence';
  @override
  Widget build(BuildContext context) {
    final String title = RousseauLocalizations.of(context).text('edit-account-residence');

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(title),
      ),
      body: GraphqlQueryWidget<CurrentUser>(
        query: currentUserResidence,
        builderSuccess: (CurrentUser currentUser) {
          return _currentUserBody(currentUser);
        },
        builderLoading: () {
          return const LoadingIndicator();
        },
        builderError: (List<GraphQLError> error) {
          return Text(error.toString());
        },
      ),
    );
  }

  Widget _currentUserBody(CurrentUser currentUser) {
    _countryTextController = TextEditingController(
      text: currentUser.country != null ? currentUser.country.name : ''
    );
    _regioneTextController = TextEditingController(
      text: currentUser.regione != null ? currentUser.regione.name : ''
    );
    _provinciaTextController = TextEditingController(
      text: currentUser.provincia != null ? currentUser.provincia.name : ''
    );
    _comuneTextController = TextEditingController(
      text: currentUser.comune != null ? currentUser.comune.name : ''
    );
    _municipioTextController = TextEditingController(
      text: currentUser.municipio != null ? currentUser.municipio.name : ''
    );

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _geoAutoComplete('Country', _countryTextController),
          _geoAutoComplete('Regione', _regioneTextController),
          _geoAutoComplete('Provincia', _provinciaTextController),
          _geoAutoComplete('Comune', _comuneTextController),
          _geoAutoComplete('Municipio', _municipioTextController),
        ],
      ),
    );
  }

  Widget _geoAutoComplete(String type, TextEditingController textController){
    return TypeAheadFormField<dynamic>(
      textFieldConfiguration: TextFieldConfiguration<dynamic>(
        controller: textController,
        decoration: InputDecoration(
          labelText: type
        )
      ),          
      suggestionsCallback: (pattern) async {
        print('sugg call');
        return await itaGeoDivisionsNetworkHandler.getGeoDivList(type,pattern).then((value){
          return value.italianGeographicalDivisions.nodes;  
        });
      },
      itemBuilder: (context, dynamic suggestion) {
        print('item build call');
        ItalianGeographicalDivision geoDivision = suggestion;
        return ListTile(
          title: Text(geoDivision.name),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (dynamic suggestion) async {
        print('sugg select');
        ItalianGeographicalDivision geoDivision = suggestion;
        textController.text = geoDivision.name;
      },
    );
  }
}
