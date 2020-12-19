import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';

@singleton
class BlogInstantArticlesCache {
  final HashMap<String, BlogInstantArticle> _cache =
      HashMap<String, BlogInstantArticle>();

  BlogInstantArticle getInstantArticle(String slug) => _cache[slug];

  void addInstantArticles(List<BlogInstantArticle> instantArticles) =>
      instantArticles.forEach(addInstantArticle);

  void addInstantArticle(BlogInstantArticle instantArticle) =>
      _cache[instantArticle.slug] = instantArticle;
}
