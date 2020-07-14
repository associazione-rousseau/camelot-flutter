// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile()
    ..id = json['id'] as String
    ..slug = json['slug'] as String
    ..accountType = json['accountType'] as String
    ..gender = json['gender'] as String
    ..fullName = json['fullName'] as String
    ..lastName = json['lastName'] as String
    ..firstName = json['firstName'] as String;
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'accountType': instance.accountType,
      'gender': instance.gender,
      'fullName': instance.fullName,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
    };
