
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';

class UserProfileWidget extends StatelessWidget {

  const UserProfileWidget(this._userProfile);

  final UserProfile _userProfile;

  @override
  Widget build(BuildContext context) {
    return Text(_userProfile.fullName);
  }
}
