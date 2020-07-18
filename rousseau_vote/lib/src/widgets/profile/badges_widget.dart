
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';

class BadgesWidget extends StatelessWidget {

  BadgesWidget(UserProfile userProfile) : _badgeImagesPaths = getActiveBadgesImages(userProfile);

  final List<String> _badgeImagesPaths;

  @override
  Widget build(BuildContext context) {
    final List<Widget> badgeImagesWidgets = <Widget>[];
    for (String badgeImagePath in _badgeImagesPaths) {
      badgeImagesWidgets.add(Container(
          padding: const EdgeInsets.only(left: 6),
          child: Image.asset(
            badgeImagePath,
            width: 40,
          )));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: badgeImagesWidgets,
    );
  }

}