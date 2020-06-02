import 'package:json_annotation/json_annotation.dart';

part 'blog_instant_article.g.dart';

@JsonSerializable()
class BlogInstantArticle {
  BlogInstantArticle();

  factory BlogInstantArticle.fromJson(Map<String, dynamic> json) => _$BlogInstantArticleFromJson(json);
  Map<String, dynamic> toJson() => _$BlogInstantArticleToJson(this);

  String id;
  String image;
  DateTime date;
  String text;
  String url;
  String slug;



}