
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/profile/user_profile_section.dart';

class UserProfileWidget extends StatelessWidget {

  const UserProfileWidget({this.userProfile, this.isLoading = false});

  final UserProfile userProfile;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 188,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.red),
              title: Text(userProfile.fullName),
            ),
          ),
          SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return _body();
            }, childCount: 1),
          ),
        ],
      ),
    );
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
          UserInfoSection('profile-presentation', userProfile.profile.presentation),
        ],
      );
  }
}
