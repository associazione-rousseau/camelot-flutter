import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/profile/mi_fido_icon_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/profile_section_widget.dart';

class MiFidoSection extends StatelessWidget {
  const MiFidoSection({ @required this.userProfile });

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionWidget(
      child: Column(
        children: <Widget>[
          Center(child: MiFidoIconWidget(userProfile: userProfile, size: 30,)),
          const VerticalSpace(10),
          Text('${userProfile.subscriptionCount} Mi fido'),
        ],
      )
    );
  }
}