// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribed_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribedList _$SubscribedListFromJson(Map<String, dynamic> json) {
  return SubscribedList()
    ..userPublicSubscriptions = json['userPublicSubscriptions'] == null
        ? null
        : Paginated.fromJson(
            json['userPublicSubscriptions'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : User.fromJson(value as Map<String, dynamic>));
}

Map<String, dynamic> _$SubscribedListToJson(SubscribedList instance) =>
    <String, dynamic>{
      'userPublicSubscriptions': instance.userPublicSubscriptions?.toJson(
        (value) => value,
      ),
    };
