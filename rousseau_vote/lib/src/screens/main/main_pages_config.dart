import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rousseau_vote/src/screens/blog_screen.dart';
import 'package:rousseau_vote/src/screens/activists_screen.dart';
import 'package:rousseau_vote/src/screens/events_screen.dart';
import 'package:rousseau_vote/src/screens/main/main_page.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';

const List<MainPage> MAIN_PAGES = <MainPage>[
  MainPage(
      titleKey: 'blog',
      iconData: MdiIcons.newspaperVariantOutline,
      selectedIconData: MdiIcons.newspaperVariant,
      type: MainPageType.BLOG,
      page: BlogScreen()),
  MainPage(
      titleKey: 'vote',
      iconData: MdiIcons.voteOutline,
      selectedIconData: MdiIcons.vote,
      type: MainPageType.POLLS,
      page: PollsScreen()),
  MainPage(
      titleKey: 'activists',
      iconData: MdiIcons.accountGroupOutline,
      selectedIconData: MdiIcons.accountGroup,
      type: MainPageType.ACTIVISTS,
      page: ActivistsScreen()),
  MainPage(
      titleKey: 'events',
      iconData: MdiIcons.calendarOutline,
      selectedIconData: MdiIcons.calendar,
      type: MainPageType.EVENTS,
      page: EventsScreen(),
      hasToolbar: true),
];
