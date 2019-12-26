// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) {
  return Poll()
    ..id = json['id'] as String
    ..slug = json['slug'] as String
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..status = json['status'] as String
    ..alreadyVoted = json['alreadyVoted'] as bool
    ..resultsLink = json['resultsLink'] as String
    ..optionType = json['optionType'] as String
    ..announcementLink = json['announcementLink'] as String
    ..showStartingDate = json['showStartingDate'] == null
        ? null
        : DateTime.parse(json['showStartingDate'] as String)
    ..voteStartingDate = json['voteStartingDate'] == null
        ? null
        : DateTime.parse(json['voteStartingDate'] as String)
    ..voteEndingDate = json['voteEndingDate'] == null
        ? null
        : DateTime.parse(json['voteEndingDate'] as String)
    ..alerts = (json['alerts'] as List)
        ?.map(
            (e) => e == null ? null : Alert.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..options = (json['options'] as List)
        ?.map((e) =>
            e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'alreadyVoted': instance.alreadyVoted,
      'resultsLink': instance.resultsLink,
      'optionType': instance.optionType,
      'announcementLink': instance.announcementLink,
      'showStartingDate': instance.showStartingDate?.toIso8601String(),
      'voteStartingDate': instance.voteStartingDate?.toIso8601String(),
      'voteEndingDate': instance.voteEndingDate?.toIso8601String(),
      'alerts': instance.alerts,
      'options': instance.options,
    };
