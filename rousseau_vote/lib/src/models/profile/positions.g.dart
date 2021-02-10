// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Positions _$PositionsFromJson(Map<String, dynamic> json) {
  return Positions()
    ..positions = (json['positions'] as List)
        ?.map((e) =>
            e == null ? null : Position.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PositionsToJson(Positions instance) => <String, dynamic>{
      'positions': instance.positions,
    };
