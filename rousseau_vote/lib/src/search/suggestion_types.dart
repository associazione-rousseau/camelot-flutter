import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';
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
  Widget icon(BuildContext context) => const Icon(Icons.search);

  @override
  void onTapped(BuildContext context) {
    final ActivistsSearchProvider activistsSearchProvider =
        Provider.of<ActivistsSearchProvider>(context, listen: false);
    activistsSearchProvider.onSearch(context, suggestion);
  }
}

class ProfileSuggestion extends SuggestionType<User> {
  ProfileSuggestion(User suggestion) : super(suggestion);

  @override
  Widget title(BuildContext context) {
    return Text(suggestion.fullName);
  }

  @override
  Widget subtitle(BuildContext context) {
    return Text(suggestion.residence);
  }

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

class GeographicalSuggestion
    extends SuggestionType<ItalianGeographicalDivision> {
  GeographicalSuggestion(ItalianGeographicalDivision suggestion)
      : super(suggestion);

  @override
  Widget title(BuildContext context) {
    final String text = RousseauLocalizations.getTextFormatted(
        context, '${suggestion.getType()}-full', <String>[suggestion.name]);
    return Text(text);
  }

  @override
  Widget subtitle(BuildContext context) => null;

  @override
  Widget icon(BuildContext context) =>
      const Icon(Icons.person_pin_circle_outlined);

  @override
  void onTapped(BuildContext context) {
    final ActivistsSearchProvider activistsSearchProvider =
        Provider.of<ActivistsSearchProvider>(context, listen: false);
    activistsSearchProvider.onSearchByGeographicalDivision(context, suggestion);
  }
}

class PositionSuggestion extends SuggestionType<Position> {
  PositionSuggestion(Position suggestion) : super(suggestion);

  @override
  Widget title(BuildContext context) => Text(suggestion.name);

  @override
  Widget subtitle(BuildContext context) => null;

  @override
  Widget icon(BuildContext context) => const Icon(MdiIcons.accountCheckOutline);

  @override
  void onTapped(BuildContext context) {
    final ActivistsSearchProvider activistsSearchProvider =
        Provider.of<ActivistsSearchProvider>(context, listen: false);
    activistsSearchProvider.onSearchByPosition(context, suggestion);
  }
}

class BlogArticleSuggestion extends SuggestionType<BlogInstantArticle> {
  BlogArticleSuggestion(BlogInstantArticle suggestion) : super(suggestion);

  @override
  Widget title(BuildContext context) => Text(
        suggestion.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  @override
  Widget subtitle(BuildContext context) => Text(suggestion.author.name);

  @override
  Widget icon(BuildContext context) => FittedBox(
        fit: BoxFit.contain,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: suggestion.image,
            width: 40,
            height: 40,
          ),
        ),
      );

  @override
  void onTapped(BuildContext context) =>
      openBlogInstantArticle(context, suggestion.url, suggestion.slug);
}
