import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/tirendiconto_data.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/widgets/profile/profile_section_widget.dart';

class TirendicontoSection extends StatelessWidget {
  const TirendicontoSection(
      {@required this.userProfile, this.isCurrentUser = false});

  final UserProfile userProfile;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final TirendicontoData data = userProfile.tirendiconto;
    if (data == null) {
      return Container();
    }
    final String statusTextKey =
        data.isOk ? 'tirendiconto-ok' : 'tirendiconto-ko';
    final Color statusColor = data.isOk ? Colors.green : Colors.red;
    return ProfileSectionWidget(
        child: Center(
      child: Column(
        children: <Widget>[
          Text(RousseauLocalizations.getText(context, 'tirendiconto-header')),
          Text(formatMoney(userProfile.tirendiconto.value),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            RousseauLocalizations.getText(context, statusTextKey),
            style: TextStyle(color: statusColor),
          ),
          Text(RousseauLocalizations.getTextFormatted(
              context, 'tirendiconto-last-report', [data.lastMonth])),
        ],
      ),
    ));
  }
}
