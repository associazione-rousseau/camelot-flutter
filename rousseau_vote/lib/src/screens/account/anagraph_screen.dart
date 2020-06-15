import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/label_value.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class AnagraphScreen extends StatelessWidget {
  CurrentUser currentUser;

  AnagraphScreen(this.currentUser) {
    _nameController = TextEditingController(text: currentUser.firstName);
    _lastNameController = TextEditingController(text: currentUser.lastName);
    _genderController = TextEditingController(
        text: currentUser.gender == 'M' ? 'Uomo' : 'Donna');
    _dateOfBirthController =
        TextEditingController(text: currentUser.dateOfBirth);
    _placeOfBirthController =
        TextEditingController(text: currentUser.placeOfBirth);
    _codiceFiscaleController =
        TextEditingController(text: currentUser.codiceFiscale);
  }

  static const String ROUTE_NAME = '/account_anagraph';
  TextEditingController _nameController;
  TextEditingController _lastNameController;
  TextEditingController _genderController;
  TextEditingController _dateOfBirthController;
  TextEditingController _placeOfBirthController;
  TextEditingController _codiceFiscaleController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RousseauAppBar(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Center(
              child: Text(
                'I dati anagrafici non sono modificabili.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          LabelValue(_nameController, 'Nome', false),
          LabelValue(_lastNameController, 'Cognome', false),
          LabelValue(_genderController, 'Genere', false), //
          LabelValue(_dateOfBirthController, 'Data di nascita', false),
          LabelValue(_placeOfBirthController, 'Luogo di nascita', false),
          LabelValue(_codiceFiscaleController, 'Codice fiscale', false),
        ],
      ),
      backgroundColor: BACKGROUND_GREY,
    );
  }
}
