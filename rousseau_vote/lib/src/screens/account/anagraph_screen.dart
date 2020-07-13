import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/label_value.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/providers/current_user_provider.dart';
import 'package:provider/provider.dart';

class AnagraphScreen extends StatelessWidget {

  AnagraphScreen();

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
      body: Consumer<CurrentUserProvider>(
          builder:(context, currentUserProvider, child) => ListView(
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
            LabelValue(_nameController = TextEditingController(text: currentUserProvider.currentUser.firstName),'Nome',false),
            LabelValue(_lastNameController = TextEditingController(text: currentUserProvider.currentUser.lastName),'Cognome', false),
            LabelValue(_dateOfBirthController = TextEditingController(text: currentUserProvider.currentUser.gender == 'M' ? 'Uomo' : 'Donna'), 'Genere', false),
            LabelValue(_dateOfBirthController = TextEditingController(text: currentUserProvider.currentUser.dateOfBirth), 'Data di nascita', false),
            LabelValue(_placeOfBirthController = TextEditingController(text: currentUserProvider.currentUser.placeOfBirth), 'Luogo di nascita', false),
            LabelValue(_codiceFiscaleController = TextEditingController(text: currentUserProvider.currentUser.codiceFiscale), 'Codice fiscale', false),
          ],
        ),
      ),
      backgroundColor: BACKGROUND_GREY,
    );
  }
}
