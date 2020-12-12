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
    ..firstName = json['firstName'] as String
    ..badges = (json['badges'] as List)
        ?.map(
            (e) => e == null ? null : Badge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>)
    ..userPositions = (json['userPositions'] as List)
        ?.map((e) =>
            e == null ? null : UserPosition.fromJson(e as Map<String, dynamic>))
        ?.toList();
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
      'badges': instance.badges,
      'category': instance.category,
      'tags': instance.tags,
      'profile': instance.profile,
      'userPositions': instance.userPositions,
    };
