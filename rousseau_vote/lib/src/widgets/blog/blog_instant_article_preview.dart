import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';

import 'blog_instant_article_placeholder.dart';

class BlogInstantArticlePreview extends StatelessWidget {
  const BlogInstantArticlePreview(this._article);

  final BlogInstantArticle _article;
  static const double RADIUS = 15.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//        side: BorderSide(width: 0.5, color: statusColor)),)
      elevation: 5,
      child: InkWell(
        onTap: openBlogInstantArticleAction(context, _article.url, _article.slug),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(RADIUS)),
                child: CachedNetworkImage(
                  imageUrl: _article.image,
                  placeholder: (BuildContext context, String url) =>
                      BlogInstantArticlePlaceholder(),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                      BlogInstantArticlePlaceholder(),
                ),
              ),
              const VerticalSpace(15),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 15.0, right: 15.0),
                title: Text(
                  _article.title,
                  style: const TextStyle(fontSize: 15, fontFamily: 'Roboto '),
                ),
              ),
            ]),
      ),
    );
  }
}
