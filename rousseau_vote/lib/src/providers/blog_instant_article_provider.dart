
import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/network/handlers/blog_instant_article_network_handler.dart';

import 'network_change_notifier.dart';

@singleton
class BlogInstantArticleProvider extends NetworkChangeNotifier {
  BlogInstantArticleProvider(this._networkHandler);

  final BlogInstantArticleNetworkHandler _networkHandler;
  final List<BlogInstantArticle> _instantArticles = <BlogInstantArticle>[];
  final HashMap<String, BlogInstantArticle> _instantArticleCache = HashMap<String, BlogInstantArticle>();

  List<BlogInstantArticle> getInstantArticles() {
    return _instantArticles;
  }

  Future<List<BlogInstantArticle>> loadMoreInstantArticles() async {
    startLoading();
    final List<BlogInstantArticle> newArticles = await _networkHandler.getPosts(_instantArticles.length);
    if (newArticles == null || newArticles.isEmpty) {
      setError();
      return null;
    }
    _instantArticles.addAll(newArticles);
    addInstantArticlesToCache(newArticles);
    doneLoading();
    return newArticles;
  }

  Future<BlogInstantArticle> loadArticle(String slug) async {
    startLoading();

    // checking the cache first
    final BlogInstantArticle cachedArticle = getCachedInstantArticle(slug);
    if (cachedArticle != null) {
      return cachedArticle;
    }

    final BlogInstantArticle newArticle = await _networkHandler.getPost(slug);
    if (newArticle == null) {
      setError();
      return null;
    }
    addInstantArticleToCache(newArticle);
    doneLoading();

    return newArticle;
  }

  BlogInstantArticle getCachedInstantArticle(String slug) {
    return _instantArticleCache[slug];
  }

  void addInstantArticlesToCache(List<BlogInstantArticle> instantArticles) {
    _instantArticles.forEach((BlogInstantArticle element) {
      addInstantArticleToCache(element);
    });
  }

  void addInstantArticleToCache(BlogInstantArticle instantArticle) {
    _instantArticleCache[instantArticle.slug] = instantArticle;
  }

}
