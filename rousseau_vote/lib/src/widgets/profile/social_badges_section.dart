import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

const String FACEBOOK_LOGO = 'assets/images/socials/fb_logo.png';
const String TWITTER_LOGO = 'assets/images/socials/twitter_logo.png';
const String LINKEDIN_LOGO = 'assets/images/socials/linkedin_logo.png';

class SocialBadgesSection extends StatelessWidget {
  const SocialBadgesSection(this.userProfile);

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    final List<Widget> badges = <Widget>[];

    _maybeAddBadgeWidget(
        context, badges, userProfile.profile?.facebookProfile, FACEBOOK_LOGO);
    _maybeAddBadgeWidget(
        context, badges, userProfile.profile?.twitterProfile, TWITTER_LOGO);
    _maybeAddBadgeWidget(
        context, badges, userProfile.profile?.linkedinProfile, LINKEDIN_LOGO);

    if (badges.isEmpty) {
      return Container();
    }

    return Row(
      children: badges,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  void _maybeAddBadgeWidget(
      BuildContext context, List<Widget> badges, String url, String asset) {
    if (url != null) {
      badges.add(_badgeWidget(context, url, asset));
    }
  }

  Widget _badgeWidget(BuildContext context, String url, String asset) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Image.asset(
          asset,
          width: 40,
        ),
        onTap: openUrlExternalAction(context, url),
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: url));
          showSimpleSnackbar(context, textKey: 'message-link-copied');
        },
      ),
    );
  }
}
