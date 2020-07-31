import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/profile/user_profile_section.dart';
import 'package:rousseau_vote/src/widgets/user/badge_widget.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

import 'badges_widget.dart';
import 'social_badges_section.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({this.userProfile, this.isLoading = false});

  final UserProfile userProfile;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_GREY,
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 320,
              backgroundColor: PRIMARY_RED,
              flexibleSpace: FlexibleSpaceBar(background: _header(context)),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return _body();
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
      Container(
        width: double.infinity,
        height: 380,
        color: BACKGROUND_GREY,
      ),
      Container(
        width: double.infinity,
        height: 290,
        color: PRIMARY_RED,
      ),
      Column(
        children: isLoading
            ? <Widget>[]
            : <Widget>[
                const VerticalSpace(75),
                ProfilePicture(
                    url: userProfile.profile.picture.originalUrl, radius: 50),
                const VerticalSpace(10),
                Text(
                  userProfile.fullName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _subtitle(context),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpace(20),
                _badgesCard(context),
              ],
      ),
    ]);
  }

  Widget _body() {
    if (isLoading) {
      return _loadingBody();
    }
    return _profileBody();
  }

  Widget _loadingBody() {
    return const LoadingIndicator();
  }

  Widget _profileBody() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          SocialBadgesSection(userProfile),
          UserInfoSection(
              'profile-presentation', userProfile.profile.presentation),
          UserInfoSection(
              'profile-curriculum-vitae', userProfile.profile.curriculumVitae),
          UserInfoSection('profile-curriculum-activitst',
              userProfile.profile.curriculumActivist),
          UserInfoSection('profile-political-experiences',
              userProfile.profile.politicalExperiences),
        ],
      ),
    );
  }

  String _subtitle(BuildContext context) {
    return getUserSubtitleShort(
        context,
        userProfile.profile.age,
        userProfile.residence);
  }

  Widget _badgesCard(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.all(6),
      child: BadgesWidget(
        userProfile.badges,
        35,
        showInactive: false,
      ),
    ));
  }
}
