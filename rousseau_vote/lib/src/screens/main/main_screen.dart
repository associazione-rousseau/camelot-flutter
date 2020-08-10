import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/main/main_page.dart';
import 'package:rousseau_vote/src/screens/main/main_pages_config.dart';
import 'package:rousseau_vote/src/widgets/drawer/rousseau_drawer.dart';
import 'package:rousseau_vote/src/widgets/logged_screen.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  static const String ROUTE_NAME = '/main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainPage mainPage = MAIN_PAGES[_selectedIndex];
    return LoggedScreen(
      Scaffold(
        appBar: mainPage.hasToolbar ? const RousseauAppBar(white: true) : null,
        body: Center(
          child: mainPage.page,
        ),
        drawer: RousseauDrawer(),
        bottomNavigationBar: _bottomNavigationBar(context),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];
    for(MainPage mainPage in MAIN_PAGES) {
      final String title = RousseauLocalizations.of(context).text(mainPage.titleKey);
      items.add(BottomNavigationBarItem(
        icon: Icon(mainPage.iconData),
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
