
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/icon_text_screen.dart';

class ActivistsScreen extends StatelessWidget {

  const ActivistsScreen();

  @override
  Widget build(BuildContext context) {
    final String subtitle = RousseauLocalizations.getText(context, 'elected-coming-soon');
    return Column(
      children: [
        const IconTextScreen(iconData: MdiIcons.accountGroup, messageKey: 'elected-full-title',),
        const VerticalSpace(50),
        Text(subtitle),
      ],
    );
  }
}
