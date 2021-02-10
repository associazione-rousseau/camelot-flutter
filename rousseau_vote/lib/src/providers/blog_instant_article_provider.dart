
import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/network/cache/blog_instant_articles_cache.dart';
import 'package:rousseau_vote/src/network/handlers/blog_instant_article_network_handler.dart';

import 'network_change_notifier.dart';

@singleton
class BlogInstantArticleProvider extends NetworkChangeNotifier with InitializeOnStartup {
  BlogInstantArticleProvider(this._networkHandler, this._cache);

  final BlogInstantArticleNetworkHandler _networkHandler;
  final BlogInstantArticlesCache _cache;
  final List<BlogInstantArticle> _instantArticles = <BlogInstantArticle>[];

  List<BlogInstantArticle> getInstantArticles() {
    return _instantArticles;
  }

  Future<List<BlogInstantArticle>> loadInstantArticles() async {
    return _loadInstantArticles(offset: 0, replaceExisting: true);
  }

  Future<List<BlogInstantArticle>> loadMoreInstantArticles() async {
    return _loadInstantArticles(offset: _instantArticles.length);
  }

  Future<List<BlogInstantArticle>> _loadInstantArticles({ int offset = 0, bool replaceExisting = false}) async {
    startLoading(notify: false);
    final List<BlogInstantArticle> newArticles = await _networkHandler.getPosts(offset);
    if (newArticles == null || newArticles.isEmpty) {
      setError();
      return null;
    }
    if (replaceExisting) {
      _instantArticles.clear();
    }
    _instantArticles.addAll(newArticles);
    _cache.addInstantArticles(newArticles);
    doneLoading();
    return newArticles;
  }

  Future<BlogInstantArticle> loadArticle(String slug) async {
    startLoading();

    // checking the cache first
    final BlogInstantArticle cachedArticle = _cache.getInstantArticle(slug);
    if (cachedArticle != null) {
      return cachedArticle;
    }

    final BlogInstantArticle newArticle = await _networkHandler.getPost(slug);
    if (newArticle == null) {
      setError();
      return null;
    }
    _cache.addInstantArticle(newArticle);
    doneLoading();

    return newArticle;
  }

  BlogInstantArticle getCachedInstantArticle(String slug) => _cache.getInstantArticle(slug);

  @override
  Future<void> doInitialize() async {
    await loadInstantArticles();
  }

}
