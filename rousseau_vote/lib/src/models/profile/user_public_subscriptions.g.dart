// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_public_subscriptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPublicSubscriptions _$UserPublicSubscriptionsFromJson(
    Map<String, dynamic> json) {
  return UserPublicSubscriptions()
    ..publicSubscriptions = json['publicSubscriptions'] == null
        ? null
        : Paginated.fromJson(
            json['publicSubscriptions'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : User.fromJson(value as Map<String, dynamic>));
}

Map<String, dynamic> _$UserPublicSubscriptionsToJson(
        UserPublicSubscriptions instance) =>
    <String, dynamic>{
      'publicSubscriptions': instance.publicSubscriptions?.toJson(
        (value) => value,
      ),
    };
