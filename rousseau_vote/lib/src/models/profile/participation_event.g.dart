// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipationEvent _$ParticipationEventFromJson(Map<String, dynamic> json) {
  return ParticipationEvent()
    ..title = json['title'] as String
    ..typology = json['typology'] as String
    ..startsAt = json['startsAt'] == null
        ? null
        : DateTime.parse(json['startsAt'] as String)
    ..endsAt = json['endsAt'] == null
        ? null
        : DateTime.parse(json['endsAt'] as String);
}

Map<String, dynamic> _$ParticipationEventToJson(ParticipationEvent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'typology': instance.typology,
      'startsAt': instance.startsAt?.toIso8601String(),
      'endsAt': instance.endsAt?.toIso8601String(),
    };
