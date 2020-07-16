import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/profile/user_profile_section.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

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
    return Column(
      children: <Widget>[
        SocialBadgesSection(userProfile),
        const VerticalSpace(15),
        UserInfoSection(
            'profile-presentation', userProfile.profile.presentation),
        UserInfoSection(
            'profile-curriculum-vitae', userProfile.profile.curriculumVitae),
        UserInfoSection(
            'profile-curriculum-activitst', userProfile.profile.curriculumActivist),
        UserInfoSection(
            'profile-political-experiences', userProfile.profile.politicalExperiences),
      ],
    );
  }

  String _subtitle(BuildContext context) {
    final String age = RousseauLocalizations.getTextFormatted(
        context, 'profile-age', <int>[userProfile.profile.age]);
    final String location = _getFormattedLocation(context);
    return '$age - $location';
  }

  Widget _badgesCard(BuildContext context) {
    final List<String> badgeImagesPaths = getActiveBadgesImages(userProfile);
    final List<Widget> badgeImagesWidgets = <Widget>[];
    for (String badgeImagePath in badgeImagesPaths) {
      badgeImagesWidgets.add(Container(
          padding: const EdgeInsets.only(left: 6),
          child: Image.asset(
            badgeImagePath,
            width: 40,
          )));
    }
    return Card(
        child: Container(
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: badgeImagesWidgets,
      ),
    ));
  }

  String _getFormattedLocation(BuildContext context) {
    final String pob = userProfile.profile.placeOfBirth;
    final String residence = userProfile.profile.placeOfResidence.comuneName;
    final bool samePlace = pob == residence;
    final bool isFemale = userProfile.isFemale();

    if (samePlace) {
      final String rawStringKey = isFemale
          ? 'profile-location-same-female'
          : 'profile-location-same-male';
      return RousseauLocalizations.getTextFormatted(
          context, rawStringKey, <String>[residence]);
    }
    final String rawStringKey =
        isFemale ? 'profile-location-female' : 'profile-location-male';

    return RousseauLocalizations.getTextFormatted(
        context, rawStringKey, <String>[pob, residence]);
  }
}
