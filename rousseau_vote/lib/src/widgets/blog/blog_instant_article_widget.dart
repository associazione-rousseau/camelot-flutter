import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';

class BlogInstantArticleWidget extends StatelessWidget {
  const BlogInstantArticleWidget(this._blogInstantArticle);

  final BlogInstantArticle _blogInstantArticle;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(_blogInstantArticle.image),
            ),
        ),
      ],
    );
  }
}
