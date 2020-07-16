import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/label_value.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GraphqlQueryWidget<CurrentUser>(
          query: currentUserFull,
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
