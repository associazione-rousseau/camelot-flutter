import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/widgets/change_residence_button.dart';
import 'package:rousseau_vote/src/widgets/geo_autocomplete.dart';
import 'package:rousseau_vote/src/util/residence_util.dart';


class ResidenceContentBody extends StatefulWidget {
    
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
  
  HashMap<String, TextEditingController> divisionTextControllers = HashMap<String, TextEditingController>();
  HashMap<String, ItalianGeographicalDivision> selectedDivisions = HashMap<String, ItalianGeographicalDivision>();
  TextEditingController _overseasCityTextController;
  CurrentUser currentUser;

  @override
  _ResidenceContentBodyState createState() => _ResidenceContentBodyState(currentUser, selectedDivisions, divisionTextControllers, _overseasCityTextController);
}

class _ResidenceContentBodyState extends State<ResidenceContentBody> {
  
  _ResidenceContentBodyState(this.currentUser, this.selectedDivisions, this.divisionTextControllers, this.overseasCityTextController);

  CurrentUser currentUser;
  HashMap<String,ItalianGeographicalDivision> selectedDivisions;
  HashMap<String,TextEditingController> divisionTextControllers;
  TextEditingController overseasCityTextController;

  @override
  Widget build(BuildContext context) {
    List<String> visibleDivisions = <String>[];
    bool oneEmptyFieldFlag = false;
    bool buttonEnabled = true;

    for(String division in DIVISIONS) { 
      if(selectedDivisions[division] != null){
        visibleDivisions.add(division);
      }else if(!oneEmptyFieldFlag){
        //only show municipio for comuni with descendants
        if(division == 'municipio' && selectedDivisions['comune'].descendants.isEmpty){
          continue;
        }
        visibleDivisions.add(division);
        oneEmptyFieldFlag = true;
        buttonEnabled = false;
      }
    }
    if(divisionTextControllers['country'].text != 'Italy' && overseasCityTextController.text.isEmpty) buttonEnabled = false;
    if(fieldsUnchanged(currentUser, selectedDivisions) == true) buttonEnabled = false;
    
    return Column(
      children: <Widget>[
        Expanded(
            child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                GeoAutocomplete('country', divisionTextControllers['country'], _onSuggestionSelected, selectedDivisions),
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
                visibleDivisions.contains('regione') ? GeoAutocomplete('regione', divisionTextControllers['regione'], _onSuggestionSelected, selectedDivisions) : Container(),
                visibleDivisions.contains('provincia') ? GeoAutocomplete('provincia', divisionTextControllers['provincia'], _onSuggestionSelected, selectedDivisions) : Container(),
                visibleDivisions.contains('comune') ? GeoAutocomplete('comune', divisionTextControllers['comune'], _onSuggestionSelected, selectedDivisions) : Container(),
                visibleDivisions.contains('municipio') ? GeoAutocomplete('municipio', divisionTextControllers['municipio'], _onSuggestionSelected, selectedDivisions) : Container(),
              ],
            ),
          ),
        ),
        ChangeResidenceButton(buttonEnabled, selectedDivisions,overseasCityTextController.text, currentUser.slug)
      ],
    );
  }

  void _onSuggestionSelected(String type, ItalianGeographicalDivision suggestion){
    setState(() {
      selectedDivisions.update(type, (value) => suggestion);
      divisionTextControllers[type].text = suggestion.name;
      final int divisionIndex = DIVISIONS.indexOf(type);
      DIVISIONS.asMap().forEach((int index, String value) { 
        if(index <= divisionIndex) return;
        selectedDivisions.update(value, (ItalianGeographicalDivision value) => null);
        divisionTextControllers[value].text = '';
      });
    });
  }
}