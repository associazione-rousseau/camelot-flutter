// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollDetail _$PollDetailFromJson(Map<String, dynamic> json) {
  return PollDetail()
    ..poll = json['poll'] == null
        ? null
        : Poll.fromJson(json['poll'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PollDetailToJson(PollDetail instance) =>
    <String, dynamic>{
      'poll': instance.poll,
    };
