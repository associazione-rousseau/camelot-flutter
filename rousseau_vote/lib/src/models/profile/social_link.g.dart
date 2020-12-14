// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLink _$SocialLinkFromJson(Map<String, dynamic> json) {
  return SocialLink()
    ..social = json['social'] == null
        ? null
        : Social.fromJson(json['social'] as Map<String, dynamic>)
    ..url = json['url'] as String;
}

Map<String, dynamic> _$SocialLinkToJson(SocialLink instance) =>
    <String, dynamic>{
      'social': instance.social,
      'url': instance.url,
    };
