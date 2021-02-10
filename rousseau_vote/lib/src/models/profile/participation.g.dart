// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participation _$ParticipationFromJson(Map<String, dynamic> json) {
  return Participation()
    ..event = json['event'] == null
        ? null
        : ParticipationEvent.fromJson(json['event'] as Map<String, dynamic>)
    ..geographicalScope = json['geographicalScope'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['geographicalScope'] as Map<String, dynamic>)
    ..staff = json['staff'] as bool;
}

Map<String, dynamic> _$ParticipationToJson(Participation instance) =>
    <String, dynamic>{
      'event': instance.event,
      'geographicalScope': instance.geographicalScope,
      'staff': instance.staff,
    };
