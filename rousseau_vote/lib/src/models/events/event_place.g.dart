// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPlace _$EventPlaceFromJson(Map<String, dynamic> json) {
  return EventPlace()..formattedAddress = json['formatted_address'] as String;
}

Map<String, dynamic> _$EventPlaceToJson(EventPlace instance) =>
    <String, dynamic>{
      'formatted_address': instance.formattedAddress,
    };
