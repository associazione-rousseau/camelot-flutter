import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/interface/has_pagination.dart';

import 'package:rousseau_vote/src/models/interface/paginated.dart';
import 'package:rousseau_vote/src/models/user.dart';

part 'subscribed_list.g.dart';

@JsonSerializable()
class SubscribedList extends HasPagination<User> {
  SubscribedList();

  factory SubscribedList.fromJson(Map<String, dynamic> json) =>
      _$SubscribedListFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribedListToJson(this);

  Paginated<User> userPublicSubscriptions;

  @override
  Paginated<User> getPaginatedData() => userPublicSubscriptions;
}
