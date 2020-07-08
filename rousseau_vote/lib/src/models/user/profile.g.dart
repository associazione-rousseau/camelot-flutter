// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..picture = json['picture'] == null
        ? null
        : Picture.fromJson(json['picture'] as Map<String, dynamic>)
    ..age = json['age'] as int
    ..placeOfResidence = json['placeOfResidence'] == null
        ? null
        : PlaceOfResidence.fromJson(
            json['placeOfResidence'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'picture': instance.picture,
      'age': instance.age,
      'placeOfResidence': instance.placeOfResidence,
    };
