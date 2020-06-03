
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/network/exceptions/blog_fetching_exception.dart';
import 'package:rousseau_vote/src/network/restclients/blog_instant_article_rest_client.dart';

@singleton
class BlogInstantArticleNetworkHandler {

  BlogInstantArticleNetworkHandler() : _restClient = BlogInstantArticleRestClient(Dio());

  final BlogInstantArticleRestClient _restClient;

  Future<List<BlogInstantArticle>> getPosts(int offset) async {
    final List<BlogInstantArticle> instantArticles = await _restClient.getPosts(offset: offset);
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
