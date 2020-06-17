import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/arguments/blog_instant_article_arguments.dart';
import 'package:rousseau_vote/src/models/browser_arguments.dart';
import 'package:rousseau_vote/src/screens/blog_instant_article_screen.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';

void showRousseauSnackbar(BuildContext context,
    GlobalKey<ScaffoldState> scaffoldState, String message) {
  final SnackBar snackBar = SnackBar(
      content: Text(RousseauLocalizations.getText(context, message)),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating);

  scaffoldState.currentState.showSnackBar(snackBar);
}

String formatDate(BuildContext context, DateTime dateTime) {
  return DateFormat.yMMMd(RousseauLocalizations.of(context).currentLanguage)
      .addPattern(" '-' ")
      .add_jm()
      .format(dateTime);
}

void openUrlInternal(BuildContext context, String url) {
  if (isBlogArticle(url)) {
    openBlogArticle(context, getBlogInstantArticleArguments(url));
  } else {
    openLink(context, BrowserArguments(url: url));
  }
}

Function openUrlInternalAction(BuildContext context, String url) {
  return () {
    openUrlInternal(context, url);
  };
}

void openBlogArticle(
    BuildContext context, BlogInstantArticleArguments arguments) {
  Navigator.of(context)
      .pushNamed(BlogInstantArticleScreen.ROUTE_NAME, arguments: arguments);
}

void openLink(BuildContext context, BrowserArguments arguments) {
  Navigator.of(context)
      .pushNamed(InAppBrowser.ROUTE_NAME, arguments: arguments);
}

Function openLinkAction(BuildContext context, BrowserArguments arguments) {
  return () {
    openLink(context, arguments);
  };
}

void openRoute(BuildContext context, String route,
    {Object arguments, bool replace = false}) {
  if (replace) {
    Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
  } else {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }
}

Function openRouteAction(BuildContext context, String route,
    {Object arguments, bool replace = false}) {
  return () {
    openRoute(context, route, arguments: arguments, replace: replace);
  };
}

BlogInstantArticleArguments getBlogInstantArticleArguments(String url) {
  final String slug = getArticleSlug(url);
  return BlogInstantArticleArguments(slug);
}

String getArticleSlug(String url) {
  // TODO remove
  return 'lapp-immuni-garantite-privacy-e-sicurezza-nuovo-strumento-nella-lotta-al-covid-19';
}

bool isBlogArticle(String url) {
  return url.startsWith("https://www.ilblogdellestelle.it/");
}
