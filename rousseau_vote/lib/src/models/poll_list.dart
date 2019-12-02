import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/poll.dart';

part 'poll_list.g.dart';

@JsonSerializable()
class PollList {

  PollList();

  factory PollList.fromJson(Map<String, dynamic> json) => _$PollListFromJson(json);
  Map<String, dynamic> toJson() => _$PollListToJson(this);

  List<Poll> polls;
}