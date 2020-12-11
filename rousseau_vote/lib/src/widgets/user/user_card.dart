import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/badges_widget.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

typedef CardTapCallback = void Function(BuildContext);

class UserCard extends StatelessWidget {
  const UserCard({ @required this.user, this.selected = false, this.onTap, this.showProfileButton = false});

  final User user;
  final bool selected;
  final bool showProfileButton;
  final CardTapCallback onTap;

  static const double DEFAULT_SPACING = 30;
  static const double PROFILE_PICTURE_RADIUS = 30;

  @override
  Widget build(BuildContext context) {
    final String subtitle = getUserSubtitleShort(
        context, user.profile.age, user.residence);
    return Card(
      shape: RoundedRectangleBorder(
          side: selected ? const BorderSide(color: PRIMARY_RED, width: 2.0) : BorderSide.none,
          borderRadius: BorderRadius.circular(DEFAULT_SPACING)),
      elevation: 5,
      child: InkWell(
        onTap: () => onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: ProfilePicture(url: user.getProfilePictureUrl(), radius: PROFILE_PICTURE_RADIUS),
                title: Text(
                  user.fullName,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(subtitle),
              ),
              BadgesWidget(user.badges, 25),
              const VerticalSpace(10),
              ConditionalWidget(condition: showProfileButton, child: _profileButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileButton(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonPadding: const EdgeInsets.all(0),
      children: <Widget>[
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'profile').toUpperCase(),
            style: const TextStyle(fontSize: 15),
          ),
          onPressed: openProfileAction(context, user.slug),
        ),
      ],
    );
  }
}
