import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';

import 'blog_instant_article_placeholder.dart';

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
            background: CachedNetworkImage(
              imageUrl: _blogInstantArticle.image,
              placeholder: (BuildContext context, String url) =>
                  BlogInstantArticlePlaceholder(),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  BlogInstantArticlePlaceholder(),
            ),
          ),
        ),
      ],
    );
  }
}
