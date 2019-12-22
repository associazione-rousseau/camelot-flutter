
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RousseauAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Image(
        image: AssetImage('assets/images/rousseau_white.png'),
        height: 50,
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

}