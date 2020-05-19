
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/widgets/drawer/drawer_item.dart';
import 'package:rousseau_vote/src/widgets/drawer/rousseau_drawer_header.dart';

class RousseauDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          RousseauDrawerHeader(),
          DrawerItem(
            textKey: 'drawer-vote',
            iconData: Icons.account_balance,
            onTap: () {},
          ),
          DrawerItem(
            textKey: 'drawer-edit-account',
            iconData: Icons.person,
            onTap: () {

            },
          ),
          DrawerItem(
            textKey: 'drawer-feedback',
            iconData: Icons.feedback,
            onTap: () {

            },
          ),
          DrawerItem(
            textKey: 'drawer-support',
            iconData: Icons.favorite,
            onTap: () {
            },
          ),
          const Divider(height: 3),
          DrawerItem(
            textKey: 'drawer-other-functionalities',
            iconData: Icons.devices,
            onTap: () {
            },
          ),
          DrawerItem(
            textKey: 'drawer-blog',
            iconData: Icons.star,
            onTap: () {

            },
          ),
          DrawerItem(
            textKey: 'drawer-privacy',
            iconData: Icons.security,
            onTap: () {

            },
          ),
          const Divider(height: 3),
          DrawerItem(
            textKey: 'drawer-logout',
            iconData: Icons.exit_to_app,
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
  
}