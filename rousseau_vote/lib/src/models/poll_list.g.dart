// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollList _$PollListFromJson(Map<String, dynamic> json) {
  return PollList()
    ..pollsConnection =
        PollList.sortPolls(json['pollsConnection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PollListToJson(PollList instance) => <String, dynamic>{
      'pollsConnection': instance.pollsConnection?.toJson(
        (value) => value,
      ),
    };
