import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/user/profile.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUser {

  CurrentUser();

  factory CurrentUser.fromJson(Map<String, dynamic> json) => _$CurrentUserFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);

  String id;
  String fullName;
  String statusColor;
  DateTime createdAt;
  DateTime voteRightStartingCountDate;
  Profile profile;
}
