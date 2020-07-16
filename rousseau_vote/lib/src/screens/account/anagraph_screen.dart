import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/label_value.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/providers/current_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

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

    final String title = RousseauLocalizations.of(context).text('edit-account-anagraph');

    final CurrentUserProvider provider = Provider.of<CurrentUserProvider>(context);
    final CurrentUser currentUser = provider.getCurrentUser();

    Widget body;

    if (currentUser != null) {
      body = _currentUserBody(currentUser);
    } else if (provider.isLoading()) {
      body = _loadingBody();
    } else {
      body = _errorBody();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );

  }

  Widget _errorBody() {
    return const Text('Error');
  }

  Widget _loadingBody() {
    return const LoadingIndicator();
  }

  Widget _currentUserBody(CurrentUser currentUser) {
    return ListView(
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
        LabelValue(_nameController = TextEditingController(text: currentUser.firstName),'Nome',false),
        LabelValue(_lastNameController = TextEditingController(text: currentUser.lastName),'Cognome', false),
        LabelValue(_dateOfBirthController = TextEditingController(text: currentUser.gender == 'M' ? 'Uomo' : 'Donna'), 'Genere', false),
        LabelValue(_dateOfBirthController = TextEditingController(text: currentUser.dateOfBirth), 'Data di nascita', false),
        LabelValue(_placeOfBirthController = TextEditingController(text: currentUser.placeOfBirth), 'Luogo di nascita', false),
        LabelValue(_codiceFiscaleController = TextEditingController(text: currentUser.codiceFiscale), 'Codice fiscale', false),
      ],
    );
  }
}
