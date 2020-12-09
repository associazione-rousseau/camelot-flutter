
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/search/rousseau_search_delegate.dart';

class RousseauAppBar extends StatelessWidget implements PreferredSizeWidget {

  const RousseauAppBar({ this.white = false, this.hasBadge = false, this.hasSearch = false});

  final bool white;
  final bool hasBadge;
  final bool hasSearch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Badge(
          showBadge: hasBadge,
          position: BadgePosition.topEnd(top: 10, end: 10),
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      actions: hasSearch ? <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          iconSize: 30,
          onPressed: () => showSearch(context: context, delegate: RousseauSearchDelegate()),
        )
      ]
      : null,
      iconTheme: white ? const IconThemeData(color: PRIMARY_RED) : null,
      title: Image(
        image: white ? RED_LOGO : WHITE_LOGO,
        height: 60,
      ),
      centerTitle: true,
      backgroundColor: white ? Colors.white : PRIMARY_RED,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

}