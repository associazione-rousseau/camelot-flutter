import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

class VoteOptionsProvider extends ChangeNotifier {
  VoteOptionsProvider();

  final List<Option> _selectedOptions = <Option>[];

  Poll _poll;

  void onPollFetched(Poll poll) {
    _poll ??= poll;
  }



  void onOptionSelected(BuildContext context, Option option) {
    if(_poll.maxSelectableOptionsNumber > 1) {
      onOptionSelectedMultiple(context, option);
    } else {
      onOptionSelectedSingle(context, option);
    }
  }
  void onOptionSelectedSingle(BuildContext context, Option option) {
    if(isOptionSelected(option)) {
      _selectedOptions.remove(option);
    } else {
      _selectedOptions.clear();
      _selectedOptions.add(option);
    }
    notifyListeners();
  }

  void onOptionSelectedMultiple(BuildContext context, Option option) {
    if(isOptionSelected(option)) {
      _selectedOptions.remove(option);
      _showRemainingSnackbar(context);
      notifyListeners();
      return;
    }

    if (!canAddOption()) {
      showSimpleSnackbar(context, textKey: 'vote-limit');
      return;
    }

    _selectedOptions.add(option);
    if (canAddOption()) {
      _showRemainingSnackbar(context);
    } else {
      showSimpleSnackbar(context, textKey: 'vote-preferences-done');
    }

    notifyListeners();
  }

  void _showRemainingSnackbar(BuildContext context) {
    final String text = RousseauLocalizations.getTextPlualized(context,
        'vote-preferences-s', 'vote-preferences-p', remainingOptions());
    showSimpleSnackbar(context, text: text, duration: 5);
  }

  int remainingOptions() {
    return _poll.maxSelectableOptionsNumber - _selectedOptions.length;
  }

  bool canAddOption() {
    return remainingOptions() > 0;
  }

  bool isOptionSelected(Option option) {
    return _poll != null && _selectedOptions.contains(option);
  }

  bool hasSelectedOptions() {
    return _poll != null && _selectedOptions.isNotEmpty;
  }
}
