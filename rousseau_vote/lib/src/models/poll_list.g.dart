// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollList _$PollListFromJson(Map<String, dynamic> json) {
  return PollList()
    ..polls = (json['polls'] as List)
        ?.map(
            (e) => e == null ? null : Poll.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PollListToJson(PollList instance) => <String, dynamic>{
      'polls': instance.polls,
    };
