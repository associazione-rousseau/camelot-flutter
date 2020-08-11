import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/providers/notification_badge_provider.dart';
import 'package:rousseau_vote/src/screens/main/main_page.dart';
import 'package:rousseau_vote/src/screens/main/main_pages_config.dart';
import 'package:rousseau_vote/src/widgets/drawer/rousseau_drawer.dart';
import 'package:rousseau_vote/src/widgets/logged_screen.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, this.arguments}) : super(key: key);

  static const String ROUTE_NAME = '/main_screen';

  final MainScreenArguments arguments;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    if(widget.arguments != null) {
      for(int i = 0; i < MAIN_PAGES.length; i++) {
        if(MAIN_PAGES[i].type == widget.arguments.type) {
          _selectedIndex = i;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final MainPage mainPage = MAIN_PAGES[_selectedIndex];
    return LoggedScreen(
      ChangeNotifierProvider<NotificationBadgeProvider>(
        create: (BuildContext context) => NotificationBadgeProvider(),
        child: Consumer<NotificationBadgeProvider>(
          builder: (BuildContext context, NotificationBadgeProvider provider, Widget child) =>
            Scaffold(
              appBar: mainPage.hasToolbar ? RousseauAppBar(white: true, hasBadge: provider.shouldShowDrawerBadge(),) : null,
              body: Center(
                child: mainPage.page,
              ),
              drawer: RousseauDrawer(),
              bottomNavigationBar: _bottomNavigationBar(context, provider),
            ),
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context, NotificationBadgeProvider provider) {
    final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];
    for(MainPage mainPage in MAIN_PAGES) {
      final String title = RousseauLocalizations.of(context).text(mainPage.titleKey);
      items.add(BottomNavigationBarItem(
        icon: Badge(child: Icon(mainPage.iconData), showBadge: provider.shouldShowBadge(mainPage.type), position: BadgePosition.topRight(top: -3, right: -3),),
        title: Text(title),
        activeIcon: Icon(mainPage.selectedIconData),
      ));
    }
    return BottomNavigationBar(
      items: items,
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: PRIMARY_RED,
      onTap: _onItemTapped,
    );
  }
}

class MainScreenArguments {

  const MainScreenArguments({ @required this.type, this.pageArguments});

  final MainPageType type;
  final Object pageArguments;
}
