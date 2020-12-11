import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

abstract class SuggestionType<T> {
  const SuggestionType(this.suggestion);

  final T suggestion;

  Widget icon(BuildContext context);

  Widget body(BuildContext context);

  bool dismissible();

  void onTapped();
}

class WordSearchSuggestion extends SuggestionType<String> {
  WordSearchSuggestion(String suggestion) : super(suggestion);

  @override
  Widget body(BuildContext context) {
    return Text(suggestion);
  }

  @override
  bool dismissible() => true;

  @override
  Widget icon(BuildContext context) => const Icon(Icons.history);

  @override
  void onTapped() {

  }
}

class ProfileSuggestion extends SuggestionType<User> {
  ProfileSuggestion(User suggestion, { this.isDismissible }) : super(suggestion);

  final bool isDismissible;

  @override
  Widget body(BuildContext context) {
    return Text(suggestion.fullName);
  }

  @override
  bool dismissible() => isDismissible;

  @override
  Widget icon(BuildContext context) => ProfilePicture(
        url: suggestion.getProfilePictureUrl(),
        radius: 15,
      );

  @override
  void onTapped() {

  }
}
