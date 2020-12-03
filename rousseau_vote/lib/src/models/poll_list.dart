import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/poll.dart';

import 'interface/paginated.dart';

part 'poll_list.g.dart';

@JsonSerializable()
class PollList {
  PollList();

  factory PollList.fromJson(Map<String, dynamic> json) => _$PollListFromJson(json);
  Map<String, dynamic> toJson() => _$PollListToJson(this);

  Paginated<Poll> pollsConnection;

  List<Poll> get polls => pollsConnection.nodes;
}
