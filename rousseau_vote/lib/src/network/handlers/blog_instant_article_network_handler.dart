
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/network/cache/blog_instant_articles_cache.dart';
import 'package:rousseau_vote/src/network/exceptions/blog_fetching_exception.dart';
import 'package:rousseau_vote/src/network/restclients/blog_instant_article_rest_client.dart';

@singleton
class BlogInstantArticleNetworkHandler {

  BlogInstantArticleNetworkHandler() : _restClient = BlogInstantArticleRestClient(Dio());

  final BlogInstantArticleRestClient _restClient;

  Future<List<BlogInstantArticle>> getPosts(int offset, {String search, String authorRousseauSlug, int perPage = DEFAULT_ARTICLES_PER_PAGE }) async {
    final List<BlogInstantArticle> instantArticles = await _restClient.getPosts(offset: offset, search: search, authorRousseauSlug: authorRousseauSlug, perPage: perPage);
    getIt<BlogInstantArticlesCache>().addInstantArticles(instantArticles);
    if (instantArticles == null) {
      throw BlogFetchingException();
    }
    return instantArticles;
  }

  Future<BlogInstantArticle> getPost(String slug) async {
    final BlogInstantArticle instantArticle = await _restClient.getPost(slug);
    if (instantArticle == null) {
      throw BlogFetchingException();
    }
    return instantArticle;
  }
}
