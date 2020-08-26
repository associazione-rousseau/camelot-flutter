// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsListResponse _$EventsListResponseFromJson(Map<String, dynamic> json) {
  return EventsListResponse()
    ..code = json['code'] as int
    ..message = json['message'] as String
    ..events = (json['events'] as List)
        ?.map(
            (e) => e == null ? null : Event.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EventsListResponseToJson(EventsListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'events': instance.events,
    };
