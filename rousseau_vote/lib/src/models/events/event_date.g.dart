// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDate _$EventDateFromJson(Map<String, dynamic> json) {
  return EventDate()
    ..date = json['date'] as String
    ..start = json['start'] as String
    ..end = json['end'] as String
    ..timestamp = EventDate.parseTimestamp(json['timestamp'] as String);
}

Map<String, dynamic> _$EventDateToJson(EventDate instance) => <String, dynamic>{
      'date': instance.date,
      'start': instance.start,
      'end': instance.end,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
