import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/mi_fido_icon_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/profile_section_widget.dart';

class MiFidoSection extends StatelessWidget {
  const MiFidoSection({@required this.userProfile, this.isCurrentUser = false});

  final UserProfile userProfile;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final String text = RousseauLocalizations.getTextFormatted(context, 'mi-fido-count', [userProfile.subscriptionCount ?? 0]);
    return ProfileSectionWidget(
        child: Column(
      children: <Widget>[
        ConditionalWidget(
            condition: !isCurrentUser,
            child: Center(
                child: MiFidoIconWidget(
              userProfile: userProfile,
              size: 30,
            ))),
        const VerticalSpace(10),
        Text(text),
      ],
    ));
  }
}
