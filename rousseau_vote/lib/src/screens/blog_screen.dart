import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/providers/blog_instant_article_provider.dart';
import 'package:rousseau_vote/src/widgets/blog/blog_instant_article_card.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key key}) : super(key: key);

  static const String ROUTE_NAME = '/blog';

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  bool _error;
  bool _loading;
  List<BlogInstantArticle> _instantArticles;

  @override
  void initState() {
    super.initState();
    _error = false;

    final BlogInstantArticleProvider provider = Provider.of<BlogInstantArticleProvider>(context, listen: false);
    _instantArticles = provider.getInstantArticles();
    if (_instantArticles.isEmpty) {
      _loading = true;
      _loadArticles();
    } else {
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = RousseauLocalizations.getText(context, 'drawer-blog');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadMore();
          }
        },
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
          padding: const EdgeInsets.all(20),
          itemCount: _instantArticles.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return (index == _instantArticles.length)
                ? const LoadingIndicator()
                : BlogInstantArticleCard(_instantArticles[index]);
          },
        ),
      ),
    );
  }

  void _loadArticles() {
    final BlogInstantArticleProvider provider = Provider.of<BlogInstantArticleProvider>(context, listen: false);
    final Future<List<BlogInstantArticle>> future = provider.loadMoreInstantArticles();
    future.then((List<BlogInstantArticle> articles) => _onResults(articles))
        .catchError((Object error) => _onError(error));
  }

  void _onError(Object error) {
    setState(() {
      _error = true;
      _loading = false;
    });
  }

  void _onResults(List<BlogInstantArticle> instantArticles) {
    setState(() {
      _instantArticles.addAll(instantArticles);
      _error = false;
      _loading = false;
    });
  }

  void _loadMore() {
    _loadArticles();
  }
}
