import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

class VoteOptionsProvider extends ChangeNotifier {
  VoteOptionsProvider();

  final List<Option> _selectedOptions = <Option>[];

  Poll _poll;
  String _searchValue = '';
  final List<bool> selectedBadges = List<bool>.filled(BADGES_NUMBER, false, growable: false);

  void onPollFetched(Poll poll) {
    _poll ??= poll;
  }

  void onBadgeTapped(int badgeNumber) {
    selectedBadges[badgeNumber] = !selectedBadges[badgeNumber];
    notifyListeners();
  }

  bool isBadgeSelected(int i) => selectedBadges[i];

  PollType getPollType() {
    return _poll.type;
  }

  bool isCandidatePoll() {
    return _poll.isCandidatePoll;
  }

  void onOptionSelected(BuildContext context, Option option) {
    if (_poll.scheduled) {
      showSimpleSnackbar(context, textKey: 'vote-published', duration: 5);
      return;
    }
    if (_poll.maxSelectableOptionsNumber > 1) {
      onOptionSelectedMultiple(context, option);
    } else {
      onOptionSelectedSingle(context, option);
    }
  }

  void onSearchChanged(String value) {
    _searchValue = value.toLowerCase();
    notifyListeners();
  }

  void onOptionSelectedSingle(BuildContext context, Option option) {
    if (isOptionSelected(option)) {
      _selectedOptions.remove(option);
    } else {
      _selectedOptions.clear();
      _selectedOptions.add(option);
    }
    notifyListeners();
  }

  void onOptionSelectedMultiple(BuildContext context, Option option) {
    if (isOptionSelected(option)) {
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

  int selectedOptionsCount() {
    return _selectedOptions.length;
  }

  List<Option> getSelectedOptions() {
    return _selectedOptions;
  }

  Poll getPoll() {
    return _poll;
  }

  void _showRemainingSnackbar(BuildContext context) {
    final String text = RousseauLocalizations.getTextPluralized(context,
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

  bool isOptionVisible(Option option) {
    if (_poll == null ||
        !isCandidatePoll() ||
        !option.entity.fullName.toLowerCase().contains(_searchValue)) {
      return false;
    }
    // badges check
    for(int i = 0; i < selectedBadges.length; i++) {
      if(selectedBadges[i] && !option.entity.hasBadge(i)) {
        return false;
      }
    }
    return true;
  }

  bool hasSelectedOptions() {
    return _poll != null && _selectedOptions.isNotEmpty;
  }
}
