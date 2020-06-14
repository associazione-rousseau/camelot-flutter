
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/blog/blog_instant_article.dart';

class BlogInstantArticleSummary extends StatelessWidget {

  const BlogInstantArticleSummary(this._article);

  final BlogInstantArticle _article;

  @override
  Widget build(BuildContext context) {
    return Text(_article.title);
  }
  
  

}