import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/alert.dart';
import 'package:rousseau_vote/src/models/poll.dart';

part 'poll_detail.g.dart';

@JsonSerializable()
class PollDetail {

  PollDetail();

  factory PollDetail.fromJson(Map<String, dynamic> json) => _$PollDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PollDetailToJson(this);

  Poll poll;
  
}