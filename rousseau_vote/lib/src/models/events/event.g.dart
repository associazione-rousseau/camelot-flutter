// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event()
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..campaign = json['campaign'] as String
    ..squareImage = json['image'] as String
    ..coverImage = json['cover_image'] as String
    ..permalink = json['permalink'] as String
    ..marker = json['marker'] as String
    ..newDescription = json['description'] as String
    ..legacyDescription = json['0'] as String
    ..dates = Event.parseDates(json['dates'] as Map<String, dynamic>)
    ..place = json['place'] == null
        ? null
        : EventPlace.fromJson(json['place'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'campaign': instance.campaign,
      'image': instance.squareImage,
      'cover_image': instance.coverImage,
      'permalink': instance.permalink,
      'marker': instance.marker,
      'description': instance.newDescription,
      '0': instance.legacyDescription,
      'dates': instance.dates,
      'place': instance.place,
    };
