import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/mi_fido_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/profile/profile_section_widget.dart';
import 'package:rousseau_vote/src/widgets/user/user_row.dart';

class SubscribedSection extends StatelessWidget {
  const SubscribedSection({@required this.userProfile});

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionWidget(
      child: Column(children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            RousseauLocalizations.getText(context, 'subscribed-title'),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const Divider(
          color: Colors.black38,
        ),
        const VerticalSpace(10),
        _body(context),
      ]),
//        child: Text(subscribedString(context, userProfile)),
    );
  }

  Widget _body(BuildContext context) {
    if (userProfile.subscribedCount == 0) {
      return Text(subscribedString(context, userProfile));
    }
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
            UserRow(user: userProfile.userPublicSubscriptions.nodes[index]),
        separatorBuilder: (BuildContext context, int index) => const VerticalSpace(10),
        itemCount: userProfile.userPublicSubscriptions.nodes.length);
  }
}
