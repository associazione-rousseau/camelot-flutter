

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/providers/current_user_provider.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class EditAccountScreen extends StatelessWidget {

  static const String ROUTE_NAME = '/edit_account';

  @override
  Widget build(BuildContext context) {
    final String title = RousseauLocalizations.of(context).text(
        'drawer-edit-account');

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
    return Text(currentUser.fullName);
  }
}
