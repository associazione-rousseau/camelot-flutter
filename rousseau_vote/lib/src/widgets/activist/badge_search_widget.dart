import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/widgets/profile/badge_image.dart';

class BadgeSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActivistsSearchProvider provider = Provider.of(context);
    final List<Widget> badges = <Widget>[];
    for (int i = 0; i < BADGES_NUMBER; i++) {
      final bool active = provider.isBadgeSelected(i);
      badges.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2,),
        child: BadgeImage(
          badgeNumber: i,
          size: 35,
          active: active,
          onTap: () => provider.onBadgeTapped(i),
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: badges,
    );
  }
}
