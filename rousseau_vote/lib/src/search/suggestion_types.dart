import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

abstract class SuggestionType<T> {
  const SuggestionType(this.suggestion);

  final T suggestion;

  Widget icon(BuildContext context);

  Widget title(BuildContext context);

  Widget subtitle(BuildContext context);

  bool dismissible();

  void onTapped(BuildContext context);
}

class WordSearchSuggestion extends SuggestionType<String> {
  WordSearchSuggestion(String suggestion) : super(suggestion);

  @override
  Widget title(BuildContext context) {
    return Text(suggestion);
  }

  @override
  Widget subtitle(BuildContext context) => null;

  @override
  bool dismissible() => true;

  @override
  Widget icon(BuildContext context) => const Icon(Icons.history);

  @override
  void onTapped(BuildContext context) {
    Navigator.pop(context);
    final ActivistsSearchProvider activistsSearchProvider = Provider.of<ActivistsSearchProvider>(context, listen: false);
    activistsSearchProvider.onSearch(context, suggestion);
  }
}

class ProfileSuggestion extends SuggestionType<User> {
  ProfileSuggestion(User suggestion, { this.isDismissible }) : super(suggestion);

  final bool isDismissible;

  @override
  Widget title(BuildContext context) {
    return Text(suggestion.fullName);
  }

  @override
  Widget subtitle(BuildContext context) {
    return Text(suggestion.residence);
  }

  @override
  bool dismissible() => isDismissible;

  @override
  Widget icon(BuildContext context) => ProfilePicture(
        url: suggestion.getProfilePictureUrl(),
        radius: 15,
      );

  @override
  void onTapped(BuildContext context) {
    openProfile(context, suggestion.slug);
  }
}
