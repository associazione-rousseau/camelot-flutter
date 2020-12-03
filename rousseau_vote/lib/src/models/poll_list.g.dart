// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollList _$PollListFromJson(Map<String, dynamic> json) {
  return PollList()
    ..pollsConnection = json['pollsConnection'] == null
        ? null
        : Paginated.fromJson(
            json['pollsConnection'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : Poll.fromJson(value as Map<String, dynamic>));
}

Map<String, dynamic> _$PollListToJson(PollList instance) => <String, dynamic>{
      'pollsConnection': instance.pollsConnection?.toJson(
        (value) => value,
      ),
    };
