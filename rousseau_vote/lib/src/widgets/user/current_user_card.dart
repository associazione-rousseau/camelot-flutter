import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/store/token_store.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/date_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/profile/badges_widget.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

const double PROFILE_PICTURE_RADIUS = 30;
const Map<String, IdentityWidgetData> STATUS_UI_MAPPING = <String, IdentityWidgetData>{
  'GREEN': IdentityWidgetData(Icons.done_all, Colors.green, 'user-identity-verified', 'user-can-vote'),
  'BLUE': IdentityWidgetData(Icons.done_all, Colors.blue, 'user-identity-verified', 'user-will-vote'),
  'ORANGE': IdentityWidgetData(Icons.check, Colors.orange, 'user-identity-pending', 'user-cannot-vote-yet'),
  'RED': IdentityWidgetData(Icons.error, Colors.red, 'user-identity-rejected', 'user-cannot-vote'),
  'GREY': IdentityWidgetData(Icons.error, Colors.red, 'user-identity-not-verified', 'user-cannot-vote'),
  'YELLOW': IdentityWidgetData(Icons.error, Colors.red, 'user-suspended', 'user-cannot-vote'),
  'DEFAULT': IdentityWidgetData(Icons.error, Colors.red, 'user-identity-not-verified', 'user-cannot-vote'),
};

class IdentityWidgetData {

  const IdentityWidgetData(this.icon, this.titleColor, this.titleTextKey, this.subtitleTextKey);

  final IconData icon;
  final Color titleColor;
  final String titleTextKey;
  final String subtitleTextKey;
}

class CurrentUserCard extends StatelessWidget {

  const CurrentUserCard({ this.currentUser, this.isLoading = false, this.errors });

  final CurrentUser currentUser;
  final bool isLoading;
  final List<GraphQLError> errors;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _placeholderWidget();
    } else if (currentUser != null) {
      return _currentUserBody(context, currentUser);
    } else {
      showSimpleSnackbar(context, textKey: 'error-profile-loading');
      return _placeholderWidget();
    }
  }

  Widget _currentUserBody(BuildContext context, CurrentUser currentUser) {
    return Column(
      children: <Widget>[
        _identitySection(context, currentUser),
        _badgesSection(context, currentUser),
        const VerticalSpace(10),
        _certificationSection(context, currentUser),
      ],
    );
  }

  Widget _certificationSection(BuildContext context, CurrentUser currentUser) {
    final IdentityWidgetData identityWidgetData = STATUS_UI_MAPPING.containsKey(currentUser.statusColor) ?
        STATUS_UI_MAPPING[currentUser.statusColor] :
        STATUS_UI_MAPPING['DEFAULT'];
    final String title = RousseauLocalizations.getText(context, identityWidgetData.titleTextKey);
    final String subtitle = _getIdentitySubtitle(context, currentUser, identityWidgetData);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(identityWidgetData.icon, color: identityWidgetData.titleColor),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title, style: TextStyle(color: identityWidgetData.titleColor),),
              ),
            ],
          ),
          Text(subtitle),
        ],
      ),
    );
  }

  String _getIdentitySubtitle(BuildContext context, CurrentUser currentUser, IdentityWidgetData identityWidgetData) {
    switch(currentUser.statusColor) {
      case 'GREEN':
        final String date = '${currentUser.voteRightStartingCountDate.year}';
        return RousseauLocalizations.getTextFormatted(context, identityWidgetData.subtitleTextKey, <String>[date]);
      case 'BLUE':
        final String date = '${currentUser.voteRightStartingCountDate.monthString}';
        return RousseauLocalizations.getTextFormatted(context, identityWidgetData.subtitleTextKey, <String>[date]);
      default:
        return RousseauLocalizations.getText(context, identityWidgetData.subtitleTextKey);
    }
  }

  Widget _badgesSection(BuildContext context, CurrentUser currentUser) {
    return BadgesWidget(currentUser.badges, 20, showInactive: false);
  }

  Widget _identitySection(BuildContext context, CurrentUser currentUser) {
    return InkWell(
      child: ListTile(
          leading: ProfilePicture(url: currentUser.getProfilePictureUrl(), radius: PROFILE_PICTURE_RADIUS),
          title: Text(
            currentUser.fullName,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(currentUser.residence),
          onTap: () {
            Navigator.of(context).pop();
            if (currentUser.profile != null) {
              openProfile(context, currentUser.slug);
            } else {
              showSimpleSnackbar(context, textKey: 'message-profile-not-compiled');
            }
          }
      ),
    );
  }

  Widget _placeholderWidget() {
    final TokenStore tokenStore = getIt<TokenStore>();
    return ListTile(
      leading: const ProfilePicture(radius: PROFILE_PICTURE_RADIUS),
      title: Text(
        tokenStore.getUserFullName(),
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: const Text(''),
    );
  }
}
