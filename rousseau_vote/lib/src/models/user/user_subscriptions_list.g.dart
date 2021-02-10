// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subscriptions_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscriptionsList _$UserSubscriptionsListFromJson(
    Map<String, dynamic> json) {
  return UserSubscriptionsList()
    ..id = json['id'] as String
    ..isSubscripted = json['isSubscripted'] as bool
    ..subscriptions = json['subscriptions'] == null
        ? null
        : Paginated.fromJson(
            json['subscriptions'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : Subscription.fromJson(value as Map<String, dynamic>));
}

Map<String, dynamic> _$UserSubscriptionsListToJson(
        UserSubscriptionsList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isSubscripted': instance.isSubscripted,
      'subscriptions': instance.subscriptions?.toJson(
        (value) => value,
      ),
    };
