import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/poll.dart';

import 'interface/has_pagination.dart';
import 'interface/paginated.dart';

part 'poll_list.g.dart';

@JsonSerializable()
class PollList extends HasPagination<Poll> {
  PollList();

  factory PollList.fromJson(Map<String, dynamic> json) =>
      _$PollListFromJson(json);
  Map<String, dynamic> toJson() => _$PollListToJson(this);

  @JsonKey(fromJson: sortPolls)
  Paginated<Poll> pollsConnection;

  List<Poll> get polls => pollsConnection.nodes;

  static Paginated<Poll> sortPolls(Map<String, dynamic> json) {
    final Paginated<Poll> pollsConnection = Paginated<Poll>.fromJson(
        json,
        (Object value) => value == null
            ? null
            : Poll.fromJson(value as Map<String, dynamic>));

    pollsConnection.nodes.sort((Poll poll1, Poll poll2) {
      if (poll1 == null || poll2 == null || poll1.status == null || poll2.status == null) {
        return 0;
      }
      if (poll1.status == poll2.status) {
        if (poll1.createdAt == null) {
          return -1;
        }
        if (poll2.createdAt == null) {
          return 1;
        }
        return poll2.createdAt.compareTo(poll1.createdAt);
      }

      return poll1.pollStatus.index - poll2.pollStatus.index;
    });

    return pollsConnection;
  }

  @override
  Paginated<Poll> getPaginatedData() => pollsConnection;
}
