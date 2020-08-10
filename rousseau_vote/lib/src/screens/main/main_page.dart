import 'package:flutter/material.dart';

class MainPage {
  const MainPage(
      {@required this.titleKey,
      @required this.iconData,
      @required this.selectedIconData,
      @required this.page,
      @required this.type,
      this.hasToolbar = true});

  final String titleKey;
  final IconData iconData;
  final IconData selectedIconData;
  final Widget page;
  final bool hasToolbar;
  final MainPageType type;
}

enum MainPageType {
  BLOG, POLLS, ELECTED, PROFILE
}
