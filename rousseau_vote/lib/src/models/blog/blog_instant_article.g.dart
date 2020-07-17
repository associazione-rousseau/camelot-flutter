// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_instant_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogInstantArticle _$BlogInstantArticleFromJson(Map<String, dynamic> json) {
  return BlogInstantArticle()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..image = json['image'] as String
    ..date =
        json['date'] == null ? null : DateTime.parse(json['date'] as String)
    ..text = json['text'] as String
    ..summary = json['summary'] as String
    ..url = json['url'] as String
    ..slug = json['slug'] as String
    ..author = json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>)
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BlogInstantArticleToJson(BlogInstantArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'date': instance.date?.toIso8601String(),
      'text': instance.text,
      'summary': instance.summary,
      'url': instance.url,
      'slug': instance.slug,
      'author': instance.author,
      'category': instance.category,
    };
