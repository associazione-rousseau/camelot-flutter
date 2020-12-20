import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/widgets/blog/blog_instant_article_preview.dart';

class BlogArticlesCarousel extends StatelessWidget {
  const BlogArticlesCarousel(this._instantArticles);

  final List<BlogInstantArticle> _instantArticles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: PageView.builder(
        itemCount: _instantArticles.length,
        controller: PageController(viewportFraction: 0.8),
        itemBuilder: (_, int index) {
          return BlogInstantArticlePreview(_instantArticles[index]);
        },
      ),
    );
  }
}
