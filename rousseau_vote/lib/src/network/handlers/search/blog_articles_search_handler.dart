import 'package:injectable/injectable.dart';

import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/network/handlers/blog_instant_article_network_handler.dart';
import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

@injectable
class BlogArticlesSearchHandler extends SearchHandler {
  @override
  Future<List<SuggestionType>> doSearch(String word) async {
    final List<BlogInstantArticle> articles =
        await getIt<BlogInstantArticleNetworkHandler>()
            .getPosts(0, search: word, perPage: 3);

    return articles
        .map<BlogArticleSuggestion>(
            (BlogInstantArticle article) => BlogArticleSuggestion(article))
        .toList(growable: false);
  }
}
