import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/arguments/blog_instant_article_arguments.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/providers/blog_instant_article_provider.dart';
import 'package:rousseau_vote/src/widgets/blog/blog_instant_article_placeholder.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

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

    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 188,
            flexibleSpace: FlexibleSpaceBar(
              background: _instantArticle != null
                  ? _articleCoverImage()
                  : _articleCoverImagePlaceholder(),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return _body();
            }, childCount: 1),
          ),
        ],
      ),
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
    setState(() {
      _error = true;
      _loading = false;
    });
  }

  void _onResults(BlogInstantArticle instantArticle) {
    setState(() {
      _instantArticle = instantArticle;
      _error = false;
      _loading = false;
    });
  }

  Widget _articleBodyWidget() {
    return Html(data: _instantArticle.text);
  }

  Widget _articleLoadingWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
            SizedBox(height: 100),
            LoadingIndicator()
        ]
    );
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
