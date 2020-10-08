// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_instant_article_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _BlogInstantArticleRestClient implements BlogInstantArticleRestClient {
  _BlogInstantArticleRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://www.ilblogdellestelle.it';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<BlogInstantArticle>> getPosts(
      {offset = 0, perPage = DEFAULT_ARTICLES_PER_PAGE}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'per_page': perPage
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/wp-json/mobile_api/v1/ia_posts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            BlogInstantArticle.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<BlogInstantArticle> getPost(slug) async {
    ArgumentError.checkNotNull(slug, 'slug');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'slug': slug};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/wp-json/mobile_api/v1/ia_post',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BlogInstantArticle.fromJson(_result.data);
    return value;
  }
}
