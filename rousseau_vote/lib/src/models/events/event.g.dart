// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event()
    ..title = json['title'] as String
    ..campaign = json['campaign'] as String
    ..squareImage = json['image'] as String
    ..coverImage = json['cover_image'] as String
    ..permalink = json['permalink'] as String
    ..marker = json['marker'] as String
    ..dates = Event.parseDates(json['dates'] as Map<String, dynamic>)
    ..place = json['place'] == null
        ? null
        : EventPlace.fromJson(json['place'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'campaign': instance.campaign,
      'image': instance.squareImage,
      'cover_image': instance.coverImage,
      'permalink': instance.permalink,
      'marker': instance.marker,
      'dates': instance.dates,
      'place': instance.place,
    };
