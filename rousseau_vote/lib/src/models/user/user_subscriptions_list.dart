import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/interface/has_pagination.dart';

import 'package:rousseau_vote/src/models/interface/paginated.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/subscription.dart';

part 'user_subscriptions_list.g.dart';

@JsonSerializable()
class UserSubscriptionsList extends HasPagination<Subscription> {
  UserSubscriptionsList();

  factory UserSubscriptionsList.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionsListFromJson(json);
  Map<String, dynamic> toJson() => _$UserSubscriptionsListToJson(this);

  String id;
  bool isSubscripted;
  Paginated<Subscription> subscriptions;

  @override
  Paginated<Subscription> getPaginatedData() => subscriptions;
}
