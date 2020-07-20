import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/ita_geo_divisions_network_handler.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/util/residence_util.dart';
import 'dart:collection';

class GeoAutocomplete extends StatelessWidget {
  GeoAutocomplete(this.type,this.textController,this.onSuggestionSelected, this.selectedDivisions);

  final String type;
  final TextEditingController textController;
  final Function onSuggestionSelected;
  ItaGeoDivisionsNetworkHandler itaGeoDivisionsNetworkHandler = getIt<ItaGeoDivisionsNetworkHandler>();
  final HashMap<String,ItalianGeographicalDivision> selectedDivisions;

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<dynamic>(
      textFieldConfiguration: TextFieldConfiguration<dynamic>(
        controller: textController,
        decoration: InputDecoration(
          labelText: RousseauLocalizations.of(context).text(type)
        )
      ),          
      suggestionsCallback: (pattern) async {
        if(type=='country'){
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
    );
  }
}