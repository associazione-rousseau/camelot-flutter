import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_detail.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';
import 'package:rousseau_vote/src/network/handlers/poll_network_handler.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

class VoteOptionsProvider extends ChangeNotifier {
  VoteOptionsProvider({@required String pollId}) {
    _fetchPollDetails(pollId: pollId);
  }

  bool get isLoading => _loading;

  final List<Option> _selectedOptions = <Option>[];

  bool _loading = false;
  dynamic error;
  Poll _poll;
  PollType pollType;
  int optionsCount = 0;
  String _searchValue = '';
  final List<bool> selectedBadges =
      List<bool>.filled(BADGES_NUMBER, false, growable: false);

  void onLoadMoreOptions() {
    _fetchPollDetails(pollId: _poll.id, after: _poll.currentEndCursor, fullName: _searchValue);
  }

  void _fetchPollDetails(
      {@required String pollId,
      String after,
      String fullName,
      List<String> badges}) {
    if(_loading) {
      return;
    }
    _loading = true;

    getIt<PollNetworkHandler>()
        .fetchPollDetails(
      pollId: pollId,
      after: after,
      fullName: fullName,
      badges: badges,
    )
        .then((Poll poll) {
      if (after != null) {
        poll.mergePreviousOptions(_poll.options);
      }
      if (optionsCount == 0) {
        optionsCount = poll.optionsConnection.totalCount;
      }
      if (_poll != null) {
        poll.cachedType = _poll.type;
      }
      _poll = poll;
      error = null;
      _loading = false;
      notifyListeners();
    }).catchError((dynamic error) {
      error = error;
      _loading = false;
      notifyListeners();
    });
  }

  void onBadgeTapped(int badgeNumber) {
    selectedBadges[badgeNumber] = !selectedBadges[badgeNumber];
    if(serverSideFilter) {
      _fetchPollDetails(pollId: poll.id, fullName: _searchValue, badges: getActiveBadgeNames(selectedBadges));
    }
    notifyListeners();
  }

  bool isBadgeSelected(int i) => selectedBadges[i];

  PollType getPollType() {
    pollType ??= _poll.type;
    return pollType;
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

  void onSearchSubmitted(String value) {
    _searchValue = value.toLowerCase();

    if(serverSideFilter) {
      _fetchPollDetails(pollId: poll.id, fullName: _searchValue, badges: getActiveBadgeNames(selectedBadges));
    }
    notifyListeners();
  }

  bool get serverSideFilter => poll == null || poll.options == null || poll.options.length == null || poll.options.length < optionsCount;

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

  Poll get poll => _poll;

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
    for (int i = 0; i < selectedBadges.length; i++) {
      if (selectedBadges[i] && !option.entity.hasBadge(i)) {
        return false;
      }
    }
    return true;
  }

  bool hasSelectedOptions() {
    return _poll != null && _selectedOptions.isNotEmpty;
  }
}
