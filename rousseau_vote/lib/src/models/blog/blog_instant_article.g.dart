// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_instant_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogInstantArticle _$BlogInstantArticleFromJson(Map<String, dynamic> json) {
  return BlogInstantArticle()
    ..id = json['id'] as String
    ..image = json['image'] as String
    ..date =
        json['date'] == null ? null : DateTime.parse(json['date'] as String)
    ..text = json['text'] as String
    ..url = json['url'] as String
    ..slug = json['slug'] as String;
}

Map<String, dynamic> _$BlogInstantArticleToJson(BlogInstantArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'date': instance.date?.toIso8601String(),
      'text': instance.text,
      'url': instance.url,
      'slug': instance.slug,
    };
