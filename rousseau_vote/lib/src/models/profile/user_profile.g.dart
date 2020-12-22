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
    ..fullName = json['fullName'] as String
    ..lastName = json['lastName'] as String
    ..firstName = json['firstName'] as String
    ..gender = json['gender'] as String
    ..isSubscripted = json['isSubscripted'] as bool
    ..subscriptionCount = json['subscriptionCount'] as int
    ..subscriptions = json['subscriptions'] == null
        ? null
        : Paginated.fromJson(
            json['subscriptions'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : Subscription.fromJson(value as Map<String, dynamic>))
    ..userPublicSubscriptions = json['userPublicSubscriptions'] == null
        ? null
        : Paginated.fromJson(
            json['userPublicSubscriptions'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : User.fromJson(value as Map<String, dynamic>))
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>)
    ..participations = json['participations'] == null
        ? null
        : Paginated.fromJson(
            json['participations'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : Participation.fromJson(value as Map<String, dynamic>))
    ..resumeDocument = json['resumeDocument'] == null
        ? null
        : ResumeDocument.fromJson(
            json['resumeDocument'] as Map<String, dynamic>)
    ..badges = (json['badges'] as List)
        ?.map(
            (e) => e == null ? null : Badge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..userPositions = (json['userPositions'] as List)
        ?.map((e) =>
            e == null ? null : UserPosition.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..tirendiconto = json['tirendiconto'] == null
        ? null
        : TirendicontoData.fromJson(
            json['tirendiconto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'accountType': instance.accountType,
      'fullName': instance.fullName,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'isSubscripted': instance.isSubscripted,
      'subscriptionCount': instance.subscriptionCount,
      'subscriptions': instance.subscriptions?.toJson(
        (value) => value,
      ),
      'userPublicSubscriptions': instance.userPublicSubscriptions?.toJson(
        (value) => value,
      ),
      'profile': instance.profile,
      'participations': instance.participations?.toJson(
        (value) => value,
      ),
      'resumeDocument': instance.resumeDocument,
      'badges': instance.badges,
      'userPositions': instance.userPositions,
      'category': instance.category,
      'tags': instance.tags,
      'tirendiconto': instance.tirendiconto,
    };
