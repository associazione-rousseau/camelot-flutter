import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/arguments/blog_instant_article_arguments.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/providers/blog_instant_article_provider.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/blog/blog_instant_article_placeholder.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/menu/rousseau_menu_item.dart';
import 'package:rousseau_vote/src/widgets/menu/web_menu_button.dart';
import 'package:rousseau_vote/src/widgets/rousseau_animated_screen.dart';
import 'package:share/share.dart';

class BlogInstantArticleScreen extends StatefulWidget {
  const BlogInstantArticleScreen(this.arguments);

  final BlogInstantArticleArguments arguments;

  static const String ROUTE_NAME = '/blog_instant_article';

  @override
  _BlogInstantArticleScreenState createState() =>
      _BlogInstantArticleScreenState();
}

class _BlogInstantArticleScreenState extends State<BlogInstantArticleScreen> {
  BlogInstantArticle _instantArticle;
  bool _loading;
  bool _error;

  @override
  void initState() {
    super.initState();
    _error = false;

    final BlogInstantArticleProvider provider =
        Provider.of<BlogInstantArticleProvider>(context, listen: false);
    _instantArticle = provider.getCachedInstantArticle(widget.arguments.slug);

    if (_instantArticle == null) {
      _loading = true;
      loadArticle();
    } else {
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = RousseauLocalizations.getText(context, 'drawer-blog');
    return RousseauAnimatedScreen(
      appBar: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      extendedAppBar: _instantArticle != null
          ? _articleCoverImage()
          : _articleCoverImagePlaceholder(),
      body: _body(),
      actions: _instantArticle != null ? _actions(context) : null,
      backgroundColor: Colors.white,
    );
  }

  Widget _body() {
    if (_loading) {
      return _articleLoadingWidget();
    }
    if (_error) {
      return _articleErrorWidget();
    }
    if (_instantArticle != null) {
      return _articleBodyWidget();
    }
  }

  List<Widget> _actions(BuildContext context) {
    return <Widget>[
      Builder(
        builder: (BuildContext scaffoldContext) {
          return WebMenuButton(url: _instantArticle.url);
        },
      ),
    ];
  }

  void loadArticle() {
    final BlogInstantArticleProvider provider =
        Provider.of<BlogInstantArticleProvider>(context, listen: false);
    final Future<BlogInstantArticle> future =
        provider.loadArticle(widget.arguments.slug);
    future
        .then((BlogInstantArticle article) => _onResults(article))
        .catchError((Object error) => _onError(error));
  }

  void _onError(Object error) {
    openUrlExternal(context, widget.arguments.url);
    goBack(context);
  }

  void _onResults(BlogInstantArticle instantArticle) {
    setState(() {
      _instantArticle = instantArticle;
      _error = false;
      _loading = false;
    });
  }

  Widget _articleBodyWidget() {
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              contentPadding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              title: Text(
                _instantArticle.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Roboto '),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const VerticalSpace(5),
                  Text('DI ' + _instantArticle.author.name.toUpperCase()),
                  const VerticalSpace(5),
                  Text(formatDateDayMonth(context, _instantArticle.date)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Html(data: _instantArticle.text, onLinkTap: (url) => openUrlExternal(context, url),),
            ),
          ]),
    );
  }

  Widget _articleLoadingWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[SizedBox(height: 100), LoadingIndicator()]);
  }

  Widget _articleErrorWidget() {
    // TODO implement it
    return const Text('Error');
  }

  Widget _articleCoverImage() {
    return CachedNetworkImage(
      imageUrl: _instantArticle.image,
      placeholder: (BuildContext context, String url) =>
          BlogInstantArticlePlaceholder(),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          BlogInstantArticlePlaceholder(),
    );
  }

  Widget _articleCoverImagePlaceholder() {
    return BlogInstantArticlePlaceholder();
  }
}
