import 'package:json_annotation/json_annotation.dart';

import 'package:rousseau_vote/src/models/user.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  Subscription();

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  String id;
  User user;
}
