import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';

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
            return _currentUserBody(currentUser, context);
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

  Widget _currentUserBody(CurrentUser currentUser, BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal:15),
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
        RoundedTextField(controller: TextEditingController(text: currentUser.firstName), labelText: 'name', enabled: false),
        RoundedTextField(controller: TextEditingController(text: currentUser.lastName), labelText: 'last-name', enabled: false),
        RoundedTextField(controller: TextEditingController(text: RousseauLocalizations.of(context).text(currentUser.gender == 'M' ? 'man' : 'woman')), labelText: 'gender', enabled: false),
        RoundedTextField(controller: TextEditingController(text: currentUser.dateOfBirth), labelText: 'dob', enabled: false),
        RoundedTextField(controller: TextEditingController(text: currentUser.placeOfBirth), labelText: 'place-of-birth', enabled: false),
        RoundedTextField(controller: TextEditingController(text: currentUser.codiceFiscale), labelText: 'ssn', enabled: false),
      ],
    );
  }
}
