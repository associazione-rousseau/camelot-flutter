import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/entity.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/providers/vote_options_provider.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/profile/badges_widget.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

class CandidateOptionCard extends StatelessWidget {
  const CandidateOptionCard(this._option, this._selected);

  final Option _option;
  final bool _selected;

  static const double DEFAULT_SPACING = 30;
  static const double PROFILE_PICTURE_RADIUS = 30;

  @override
  Widget build(BuildContext context) {
    final Entity user = _option.entity;
    final String subtitle = getUserSubtitleShort(
        context, user.profile.age, user.profile.placeOfResidence.comuneName);
    return Card(
      shape: RoundedRectangleBorder(
          side: _selected ? BorderSide(color: PRIMARY_RED, width: 2.0) : BorderSide.none,
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

  void _onTap(BuildContext context) {
    Provider.of<VoteOptionsProvider>(context).onOptionSelected(context, _option);
  }
}
