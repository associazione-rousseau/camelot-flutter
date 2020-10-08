
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

class RousseauAppBar extends StatelessWidget implements PreferredSizeWidget {

  const RousseauAppBar({ this.white = false, this.hasBadge = false});

  final bool white;
  final bool hasBadge;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Badge(
          showBadge: hasBadge,
          position: BadgePosition.topEnd(top: 10, end: 10),
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      iconTheme: white ? const IconThemeData(color: PRIMARY_RED) : null,
      title: Image(
        image: white ? RED_LOGO : WHITE_LOGO,
        height: 50,
      ),
      backgroundColor: white ? Colors.white : PRIMARY_RED,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

}