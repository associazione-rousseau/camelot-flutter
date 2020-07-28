import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/residence_change_request.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/widgets/change_residence_button.dart';
import 'package:rousseau_vote/src/widgets/geo_autocomplete.dart';
import 'package:rousseau_vote/src/util/residence_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';
import 'package:rousseau_vote/src/widgets/user/residence_request_widget.dart';


class ResidenceContentBody extends StatefulWidget {
    
  ResidenceContentBody(this.currentUser){
     if(currentUser.country != null) selectedDivisions.putIfAbsent('country', () => currentUser.country);
    divisionTextControllers.putIfAbsent('country', () => TextEditingController(text: currentUser.country != null  ? currentUser.country.name : ''));

    if(currentUser.regione != null) selectedDivisions.putIfAbsent('regione', () => currentUser.regione);
    divisionTextControllers.putIfAbsent('regione', () => TextEditingController(text: currentUser.regione != null  ? currentUser.regione.name : ''));

    if(currentUser.provincia != null) selectedDivisions.putIfAbsent('provincia', () => currentUser.provincia);
    divisionTextControllers.putIfAbsent('provincia', () => TextEditingController(text: currentUser.provincia != null  ? currentUser.provincia.name : ''));

    if(currentUser.comune != null) selectedDivisions.putIfAbsent('comune', () => currentUser.comune);
    divisionTextControllers.putIfAbsent('comune', () => TextEditingController(text: currentUser.comune != null  ? currentUser.comune.name : ''));
    

    if(currentUser.municipio != null) selectedDivisions.putIfAbsent('municipio', () => currentUser.municipio);
    divisionTextControllers.putIfAbsent('municipio', () => TextEditingController(text: currentUser.municipio != null ? currentUser.municipio.name : ''));
    
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

    if(currentUser.lastResidenceChangeRequest != null && currentUser.lastResidenceChangeRequest.status == 'PENDING'){
      return ResidenceRequestWidget(currentUser.lastResidenceChangeRequest);
    }

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
    
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:15),
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0){
                    return Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: GeoAutocomplete('country', divisionTextControllers['country'], _onSuggestionSelected, selectedDivisions),
                    );
                  }
                  if(index == 1){
                    return divisionTextControllers['country'].text != 'Italy' ? 
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: RoundedTextField(
                            controller: overseasCityTextController,
                            labelText: 'overseas-city',
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
                    Container();
                  }
                  String division = DIVISIONS[index-1];
                  return visibleDivisions.contains(division) ? GeoAutocomplete(division, divisionTextControllers[division], _onSuggestionSelected, selectedDivisions) : Container();
                }
              ),
            ),
          ),
          ChangeResidenceButton(buttonEnabled, selectedDivisions,overseasCityTextController.text, currentUser.slug, setResidenceRequest)
        ],
      ),
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

  void setResidenceRequest(ResidenceChangeRequest residenceChangeRequest){
    setState(() {
      currentUser.lastResidenceChangeRequest = residenceChangeRequest;
    });
  }
}