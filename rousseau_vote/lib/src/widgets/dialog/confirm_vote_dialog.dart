import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/util/widget/horizontal_space.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';

class ConfirmVoteDialog extends StatelessWidget {
  const ConfirmVoteDialog(
      {@required this.selectedOptions,
      @required this.onConfirm,
      @required this.pollType,
      @required this.remainingOptions});

  final List<Option> selectedOptions;
  final int remainingOptions;
  final VoidCallback onConfirm;
  final PollType pollType;

  @override
  Widget build(BuildContext context) {
    final String dismissText = RousseauLocalizations.getText(context, 'cancel');
    final String confirmText =
        RousseauLocalizations.getText(context, 'confirm');
    final String title =
        RousseauLocalizations.getText(context, 'vote-confirm-title');

    final List<FlatButton> buttons = <FlatButton>[
      FlatButton(
        child: Text(dismissText),
        onPressed: () => Navigator.of(context).pop(),
      ),
      FlatButton(
        child: Text(
          confirmText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: onConfirm,
      )
    ];

    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: PRIMARY_RED),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _header(context),
            const VerticalSpace(10),
            _selectedPreferences(context),
            const VerticalSpace(20),
            _warning(context),
            _preferencesWarning(context),
          ],
        ),
      ),
      actions: buttons,
    );
  }

  Widget _header(BuildContext context) {
    final String textKey =
        selectedOptions.length == 1 ? 'vote-content-1s' : 'vote-content-1p';
    final String text = RousseauLocalizations.getText(context, textKey);
    return Text(text);
  }

  Widget _selectedPreferences(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (Option option in selectedOptions) {
      final String text =
          pollType == PollType.CANDIDATE ? option.entity.fullName : option.text;
      children.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.check,
            color: Colors.grey,
          ),
          Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      ));
    }
    return Column(
      children: children,
    );
  }

  Widget _warning(BuildContext context) {
    final String warning =
        RousseauLocalizations.getText(context, 'vote-confirm-warning');
    return Text(
      warning,
      style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }

  Widget _preferencesWarning(BuildContext context) {
    if (remainingOptions == 0) {
      return Container();
    }
    final String message = RousseauLocalizations.getTextPluralized(
        context,
        'vote-preferences-missing-s',
        'vote-preferences-missing-p',
        remainingOptions);
    final Color color = Colors.orange;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: color,
          ),
          const HorizontalSpace(5),
          Text(
            message,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
