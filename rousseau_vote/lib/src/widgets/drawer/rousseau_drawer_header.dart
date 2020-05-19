
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/widgets/user/current_user_card.dart';

class RousseauDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      child: CurrentUserCard()
    );
  }
}