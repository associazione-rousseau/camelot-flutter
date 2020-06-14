
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/links.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/screens/blog_screen.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
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
            onTap: openRouteAction(context, PollsScreen.ROUTE_NAME, replace: true),
          ),
          DrawerItem(
            textKey: 'drawer-edit-account',
            iconData: Icons.person,
            onTap: () {
              // TODO implement
            },
          ),
          DrawerItem(
            textKey: 'drawer-feedback',
            iconData: Icons.feedback,
            onTap: () {
              // TODO implement
            },
          ),
          DrawerItem(
            textKey: 'drawer-support',
            iconData: Icons.favorite,
            onTap: openUrlInternalAction(context, SUPPORT_LINK),
          ),
          const Divider(height: 3),
          DrawerItem(
            textKey: 'drawer-other-functionalities',
            iconData: Icons.devices,
            onTap: openUrlInternalAction(context, ROUSSEAU_WEB_LINK),
          ),
          DrawerItem(
            textKey: 'drawer-blog',
            iconData: Icons.star,
            onTap: openRouteAction(context, BlogScreen.ROUTE_NAME),
          ),
          DrawerItem(
            textKey: 'drawer-privacy',
            iconData: Icons.security,
            onTap: openUrlInternalAction(context, PRIVACY_LINK),
          ),
          const Divider(height: 3),
          DrawerItem(
            textKey: 'drawer-logout',
            iconData: Icons.exit_to_app,
            onTap: () {
              Provider.of<Login>(context).logout();
            },
          ),
        ],
      ),
    );
  }
  
}