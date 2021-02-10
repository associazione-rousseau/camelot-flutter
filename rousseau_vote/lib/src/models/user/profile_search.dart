import 'package:json_annotation/json_annotation.dart';

import 'package:rousseau_vote/src/models/interface/has_pagination.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';
import 'package:rousseau_vote/src/models/user.dart';

part 'profile_search.g.dart';

@JsonSerializable()
class ProfileSearch extends HasPagination<User> {
  ProfileSearch();

  factory ProfileSearch.fromJson(Map<String, dynamic> json) =>
      _$ProfileSearchFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileSearchToJson(this);

  Paginated<User> profiles;

  @override
  Paginated<User> getPaginatedData() => profiles;
}
