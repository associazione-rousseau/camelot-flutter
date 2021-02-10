import 'package:json_annotation/json_annotation.dart';

import 'package:rousseau_vote/src/models/interface/has_pagination.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';
import 'package:rousseau_vote/src/models/user.dart';

part 'user_public_subscriptions.g.dart';

@JsonSerializable()
class UserPublicSubscriptions extends HasPagination<User> {
  UserPublicSubscriptions();

  factory UserPublicSubscriptions.fromJson(Map<String, dynamic> json) =>
      _$UserPublicSubscriptionsFromJson(json);
  Map<String, dynamic> toJson() => _$UserPublicSubscriptionsToJson(this);

  Paginated<User> publicSubscriptions;

  @override
  Paginated<User> getPaginatedData() => publicSubscriptions;
}
