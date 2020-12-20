import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/providers/blog_search_provider.dart';
import 'package:rousseau_vote/src/widgets/blog/blog_articles_carousel.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class BlogArticlesSection extends StatelessWidget {
  const BlogArticlesSection({@required this.userProfile});

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogSearchProvider>(
      create: (BuildContext context) {
        final BlogSearchProvider provider = BlogSearchProvider();
        provider.searchByAuthor(userProfile);
        return provider;
      },
      builder: (BuildContext context, Widget child) =>
          Consumer<BlogSearchProvider>(
              builder: (BuildContext context, BlogSearchProvider provider, _) =>
                  _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    final BlogSearchProvider provider =
        Provider.of<BlogSearchProvider>(context);
    if (provider.isLoading) {
      return const LoadingIndicator();
    }
    if (provider.results == null || provider.results.isEmpty) {
      return Container();
    }
    if (provider.results != null) {
      return BlogArticlesCarousel(provider.results);
    }
  }
}
