
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

class RousseauAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Image(
        image: WHITE_LOGO,
        height: 50,
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

}