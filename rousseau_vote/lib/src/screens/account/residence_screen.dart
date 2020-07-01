import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/providers/geo_list_provider.dart';
import 'package:rousseau_vote/src/widgets/edit_account/geo_dropdown.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class ResidenceScreen extends StatelessWidget {
  ResidenceScreen(this.currentUser);

  CurrentUser currentUser;

  static const String ROUTE_NAME = '/account_residence';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (context) => GeoListProvider(),
        child: Scaffold(
          appBar: RousseauAppBar(),
          body: ListView(
            children: <Widget>[GeoDropdown()],
          ),
        ));
  }
}
