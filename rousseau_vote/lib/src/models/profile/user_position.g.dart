// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPosition _$UserPositionFromJson(Map<String, dynamic> json) {
  return UserPosition()
    ..description = json['description'] as String
    ..geographicalScope = json['geographicalScope'] == null
        ? null
        : GeographicalScope.fromJson(
            json['geographicalScope'] as Map<String, dynamic>)
    ..position = json['position'] == null
        ? null
        : Position.fromJson(json['position'] as Map<String, dynamic>)
    ..startsAt = json['startsAt'] == null
        ? null
        : DateTime.parse(json['startsAt'] as String)
    ..endsAt = json['endsAt'] == null
        ? null
        : DateTime.parse(json['endsAt'] as String);
}

Map<String, dynamic> _$UserPositionToJson(UserPosition instance) =>
    <String, dynamic>{
      'description': instance.description,
      'geographicalScope': instance.geographicalScope,
      'position': instance.position,
      'startsAt': instance.startsAt?.toIso8601String(),
      'endsAt': instance.endsAt?.toIso8601String(),
    };
