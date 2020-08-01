
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class VerifyIdentityScreen extends StatelessWidget {

  static const String ROUTE_NAME = '/verify_identity';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      appBar: RousseauAppBar(),
      showDrawer: false,
      body: Container(),
    );
  }
}