import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/horizontal_space.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';

class FeedbackCategoryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        RousseauLocalizations.getText(context, 'category'),
        style: const TextStyle(color: PRIMARY_RED),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _feedbackCategoryItem(context, MdiIcons.bugOutline,
                'feedback-bug_report', 'bug_report'),
            const VerticalSpace(20),
            _feedbackCategoryItem(context, MdiIcons.arrowTopRight,
                'feedback-feature_improvement', 'feature_improvement'),
            const VerticalSpace(20),
            _feedbackCategoryItem(context, MdiIcons.monitorStar,
                'feedback-new_feature', 'new_feature'),
            const VerticalSpace(20),
            _feedbackCategoryItem(context, MdiIcons.messageTextOutline,
                'feedback-feedback', 'feedback'),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'back'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  Widget _feedbackCategoryItem(
      BuildContext context, IconData icon, String textKey, String category) {
    return GestureDetector(
      child: Row(children: <Widget>[
        Icon(icon),
        const HorizontalSpace(10),
        Text(RousseauLocalizations.getText(context, textKey))
      ]),
      onTap: () => onCategorySelected(context, category),
    );
  }

  void onCategorySelected(BuildContext context, String category) {
    Navigator.pop(context);
    openSendFeedback(context, category);
  }
}
