import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rousseau_vote/src/screens/blog_screen.dart';
import 'package:rousseau_vote/src/screens/elected_screen.dart';
import 'package:rousseau_vote/src/screens/main/main_page.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/screens/user_profile_screen.dart';

const List<MainPage> MAIN_PAGES = <MainPage>[
  MainPage(
      titleKey: 'blog',
      iconData: MdiIcons.newspaperVariantOutline,
      selectedIconData: MdiIcons.newspaperVariant,
      page: BlogScreen()),
  MainPage(
      titleKey: 'vote',
      iconData: MdiIcons.voteOutline,
      selectedIconData: MdiIcons.vote,
      page: PollsScreen()),
  MainPage(
      titleKey: 'profile',
      iconData: MdiIcons.accountOutline,
      selectedIconData: MdiIcons.account,
      page: UserProfileScreen(UserProfileArguments('emanuel-mazzilli')),
      hasToolbar: false),
  MainPage(
      titleKey: 'elected',
      iconData: MdiIcons.accountGroupOutline,
      selectedIconData: MdiIcons.accountGroup,
      page: ElectedScreen()),
];
