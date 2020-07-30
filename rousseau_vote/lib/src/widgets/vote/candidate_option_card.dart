import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/entity.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/profile/badges_widget.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

class CandidateOptionCard extends StatelessWidget {
  const CandidateOptionCard(this._option);

  final Option _option;

  static const double DEFAULT_SPACING = 30;
  static const double PROFILE_PICTURE_RADIUS = 30;

  @override
  Widget build(BuildContext context) {
    final Entity user = _option.entity;
    final String subtitle = getUserSubtitleShort(
        context, user.profile.age, user.profile.placeOfResidence.comuneName);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DEFAULT_SPACING)),
      elevation: 5,
      child: InkWell(
        onTap: () => _onTap(context),
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
                  onTap: () {}
              ),
              BadgesWidget(user.badges, 25),
              const VerticalSpace(10),
              _profileButton(context),
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
          onPressed: openProfileAction(context, _option.entity.slug),
        ),
      ],
    );
  }

  void _onTap(BuildContext context) {}
}
