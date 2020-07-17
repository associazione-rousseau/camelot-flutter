import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/network/handlers/ita_geo_divisions_network_handler.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class ResidenceContentBody extends StatefulWidget {
    
  HashMap<String, TextEditingController> divisionTextControllers = HashMap<String, TextEditingController>();
  HashMap<String, ItalianGeographicalDivision> selectedDivisions = HashMap<String, ItalianGeographicalDivision>();
  TextEditingController _overseasCityTextController;
  CurrentUser currentUser;

  ResidenceContentBody(this.currentUser){
    selectedDivisions.putIfAbsent('country', () => currentUser.country);
    divisionTextControllers.putIfAbsent('country', () => TextEditingController(text: currentUser.country.name ?? ''));

    selectedDivisions.putIfAbsent('regione', () => currentUser.regione);
    divisionTextControllers.putIfAbsent('regione', () => TextEditingController(text: currentUser.regione.name ?? ''));

    selectedDivisions.putIfAbsent('provincia', () => currentUser.provincia);
    divisionTextControllers.putIfAbsent('provincia', () => TextEditingController(text: currentUser.provincia.name ?? ''));

    selectedDivisions.putIfAbsent('comune', () => currentUser.comune);
    divisionTextControllers.putIfAbsent('comune', () => TextEditingController(text: currentUser.comune.name ?? ''));

    selectedDivisions.putIfAbsent('municipio', () => currentUser.municipio);
    divisionTextControllers.putIfAbsent('municipio', () => TextEditingController(text: currentUser.municipio.name ?? ''));
    
    _overseasCityTextController = TextEditingController(
      text: currentUser.overseaseCity
    );
  }

  ItaGeoDivisionsNetworkHandler itaGeoDivisionsNetworkHandler = getIt<ItaGeoDivisionsNetworkHandler>();

  @override
  _ResidenceContentBodyState createState() => _ResidenceContentBodyState(currentUser, itaGeoDivisionsNetworkHandler, selectedDivisions, divisionTextControllers, _overseasCityTextController);
}

class _ResidenceContentBodyState extends State<ResidenceContentBody> {
  
  _ResidenceContentBodyState(this.currentUser, this.itaGeoDivisionsNetworkHandler, this.selectedDivisions, this.divisionTextControllers, this.overseasCityTextController);

  ItaGeoDivisionsNetworkHandler itaGeoDivisionsNetworkHandler;
  CurrentUser currentUser;
  HashMap<String,ItalianGeographicalDivision> selectedDivisions;
  HashMap<String,TextEditingController> divisionTextControllers;
  TextEditingController overseasCityTextController;
  static const List<String> DIVISIONS = <String>['country','regione','provincia','comune','municipio'];
  

  @override
  Widget build(BuildContext context) {
    List<String> visibleDivisions = <String>[];
    bool oneEmptyFieldFlag = false;
    for(String division in DIVISIONS) { 
      if(selectedDivisions[division] != null){
        print(selectedDivisions[division]);
        visibleDivisions.add(division);
      }else if(!oneEmptyFieldFlag){
        visibleDivisions.add(division);
        oneEmptyFieldFlag = true;
      }
    }

    
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _geoAutoComplete('country', divisionTextControllers['country']),
          divisionTextControllers['country'].text != 'Italy' ? 
          Column(
            children: <Widget>[
              TextField(
                controller: overseasCityTextController,
                decoration: InputDecoration(
                  labelText: RousseauLocalizations.of(context).text('overseas-city'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:30,bottom: 10),
                child: Text(
                  RousseauLocalizations.of(context).text('last-italian-residence').toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ) : 
          Container(),
          visibleDivisions.contains('regione') ? _geoAutoComplete('regione', divisionTextControllers['regione']) : Container(),
          visibleDivisions.contains('provincia') ? _geoAutoComplete('provincia', divisionTextControllers['provincia']) : Container(),
          visibleDivisions.contains('comune') ? _geoAutoComplete('comune', divisionTextControllers['comune']) : Container(),
          visibleDivisions.contains('municipio') ? _geoAutoComplete('municipio', divisionTextControllers['municipio']) : Container(),
        ],
      ),
    );
  }

  Widget _geoAutoComplete(String type, TextEditingController textController){
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
        return await itaGeoDivisionsNetworkHandler.getGeoDivList(type,pattern).then((value){
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
        setState(() {
          selectedDivisions.update(type, (value) => suggestion);
          textController.text = suggestion.name;
          int divisionIndex = DIVISIONS.indexOf(type);
          DIVISIONS.asMap().forEach((index, value) { 
            if(index <= divisionIndex) return;
            selectedDivisions.update(value, (value) => null);
            divisionTextControllers[value].text = '';
          });
        });
      },
    );
  }
}