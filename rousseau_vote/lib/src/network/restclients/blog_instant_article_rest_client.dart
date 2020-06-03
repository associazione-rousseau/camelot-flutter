import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';

part 'blog_instant_article_rest_client.g.dart';

@RestApi(baseUrl: '$BLOG_URL')
abstract class BlogInstantArticleRestClient {
  factory BlogInstantArticleRestClient(Dio dio) = _BlogInstantArticleRestClient;

  @GET('/wp-json/mobile_api/v1/ia_posts')
  Future<List<BlogInstantArticle>> getPosts({@Query('offset') int offset = 0,
    @Query('per_page') int perPage = DEFAULT_ARTICLES_PER_PAGE});

  @GET('/wp-json/mobile_api/v1/ia_post')
  Future<BlogInstantArticle> getPost(@Query('slug') String slug);

}