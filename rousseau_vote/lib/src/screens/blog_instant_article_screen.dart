
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/arguments/blog_instant_article_arguments.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/providers/blog_instant_article_provider.dart';
import 'package:rousseau_vote/src/widgets/blog/blog_instant_article_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class BlogInstantArticleScreen extends StatefulWidget {

  const BlogInstantArticleScreen(this.arguments);

  final BlogInstantArticleArguments arguments;

  static const String ROUTE_NAME = '/blog_instant_article';

  @override
  _BlogInstantArticleScreenState createState() => _BlogInstantArticleScreenState();
}

class _BlogInstantArticleScreenState extends State<BlogInstantArticleScreen> {

  BlogInstantArticle _instantArticle;
  bool _loading;
  bool _error;


  @override
  void initState() {
    super.initState();
    _error = false;

    final BlogInstantArticleProvider provider = Provider.of<BlogInstantArticleProvider>(context, listen: false);
    _instantArticle = provider.getCachedInstantArticle(widget.arguments.slug);

    if(_instantArticle == null) {
      _loading = true;
      loadArticle();
    } else {
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _loadingScreen();
    }
    if (_error) {
      return _errorScreen();
    }
    if(_instantArticle != null) {
      return _articleScreen();
    }

    return _errorScreen();
  }

  void loadArticle() {
    final BlogInstantArticleProvider provider = Provider.of<BlogInstantArticleProvider>(context, listen: false);
    final Future<BlogInstantArticle> future = provider.loadArticle(widget.arguments.slug);
    future.then((BlogInstantArticle article) => _onResults(article))
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

  Widget _articleScreen() {
    return BlogInstantArticleWidget(_instantArticle);
  }

  Widget _errorScreen() {
    return const Text("Error");
  }

  Widget _loadingScreen() {
    return const LoadingIndicator();
  }
}