import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/ita_geo_divisions_network_handler.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/util/residence_util.dart';
import 'dart:collection';

import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class GeoAutocomplete extends StatelessWidget {
  GeoAutocomplete(this.type,this.textController,this.onSuggestionSelected, this.selectedDivisions);

  final String type;
  final TextEditingController textController;
  final Function onSuggestionSelected;
  ItaGeoDivisionsNetworkHandler itaGeoDivisionsNetworkHandler = getIt<ItaGeoDivisionsNetworkHandler>();
  final HashMap<String,ItalianGeographicalDivision> selectedDivisions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TypeAheadFormField<dynamic>(
        loadingBuilder: (context) => LoadingIndicator(),
        textFieldConfiguration: TextFieldConfiguration<dynamic>(
          enabled: false,
          controller: textController,
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
            labelText: RousseauLocalizations.of(context).text(type),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
          ),
        ),
        suggestionsCallback: (pattern) async {
          if(type == 'country'){
            return await itaGeoDivisionsNetworkHandler.getCountries(pattern).then((countries){
              return countries;  
            });
          }
          final int divisionIndex = DIVISIONS.indexOf(type);
          final String parentType = divisionIndex > 1 ? DIVISIONS[divisionIndex - 1] : '';
          final String parentCode = parentType.isNotEmpty ? selectedDivisions[parentType].code : '';
          return await itaGeoDivisionsNetworkHandler.getGeoDivList(type,pattern,parentType,parentCode).then((value){
            return value.italianGeographicalDivisions.nodes;  
          });
        },
        itemBuilder: (context, dynamic suggestion) {
          ItalianGeographicalDivision geoDivision = suggestion;
          return ListTile(
            title: Text(geoDivision.name),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (dynamic suggestion) async {
          onSuggestionSelected(type,suggestion);
        },
      ),
    );
  }
}