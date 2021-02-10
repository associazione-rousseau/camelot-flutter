import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/network/cache/blog_instant_articles_cache.dart';
import 'package:rousseau_vote/src/network/handlers/blog_instant_article_network_handler.dart';

class BlogSearchProvider extends ChangeNotifier {
  bool isLoading = false;
  List<BlogInstantArticle> results;

  void searchByAuthor(UserProfile userProfile) {
    isLoading = true;
    final Future<List<BlogInstantArticle>> future =
        getIt<BlogInstantArticleNetworkHandler>()
            .getPosts(0, authorRousseauSlug: userProfile.slug);
    future
        .then((List<BlogInstantArticle> articles) {
          results = articles;
          getIt<BlogInstantArticlesCache>().addInstantArticles(articles);
          notifyListeners();
        })
        .catchError((Object error) => print(error))
        .whenComplete(() {
          isLoading = false;
          notifyListeners();
        });

    notifyListeners();
  }
}
