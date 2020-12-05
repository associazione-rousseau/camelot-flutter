import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/poll.dart';

import 'interface/has_pagination.dart';
import 'interface/paginated.dart';

part 'poll_list.g.dart';

@JsonSerializable()
class PollList implements HasPagination<Poll> {
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


    final List<Poll> sortedNodes = <Poll>[];
    sortedNodes.addAll(pollsConnection.nodes.where((Poll p) => p.pollStatus == PollStatus.OPEN));
    sortedNodes.addAll(pollsConnection.nodes.where((Poll p) => p.pollStatus == PollStatus.PUBLISHED));
    sortedNodes.addAll(pollsConnection.nodes.where((Poll p) => p.pollStatus == PollStatus.CLOSED));
    pollsConnection.nodes = sortedNodes;

    return pollsConnection;
  }

  @override
  String afterCursor() => pollsConnection.afterCursor();

  @override
  bool hasNext() => pollsConnection.hasNext();

  @override
  void mergePreviousPage(HasPagination<Poll> newData) => pollsConnection.mergePreviousPage(newData.getPaginatedData());

  @override
  Paginated<Poll> getPaginatedData() => pollsConnection;

  @override
  int getItemCount() => pollsConnection != null && pollsConnection.nodes != null ? pollsConnection.nodes.length : 0;

  @override
  Poll getItem(int index) => pollsConnection.nodes[index];
}
