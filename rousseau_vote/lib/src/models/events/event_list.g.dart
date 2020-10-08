// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventList _$EventListFromJson(Map<String, dynamic> json) {
  return EventList()
    ..events = (json['events'] as List)
        ?.map(
            (e) => e == null ? null : Event.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..label = json['label'] as String;
}

Map<String, dynamic> _$EventListToJson(EventList instance) => <String, dynamic>{
      'events': instance.events,
      'label': instance.label,
    };
