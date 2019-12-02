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
    ..status = _$enumDecodeNullable(_$PollStatusEnumMap, json['status'])
    ..alreadyVoted = json['alreadyVoted'] as bool
    ..description = json['description'] as String
    ..optionType = json['optionType'] as String
    ..resultsLink = json['resultsLink'] as String
    ..announcementLink = json['announcementLink'] as String
    ..alerts = (json['alerts'] as List)
        ?.map(
            (e) => e == null ? null : Alert.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..showStartingDate = json['showStartingDate'] == null
        ? null
        : DateTime.parse(json['showStartingDate'] as String)
    ..voteStartingDate = json['voteStartingDate'] == null
        ? null
        : DateTime.parse(json['voteStartingDate'] as String)
    ..voteEndingDate = json['voteEndingDate'] == null
        ? null
        : DateTime.parse(json['voteEndingDate'] as String);
}

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'status': _$PollStatusEnumMap[instance.status],
      'alreadyVoted': instance.alreadyVoted,
      'description': instance.description,
      'optionType': instance.optionType,
      'resultsLink': instance.resultsLink,
      'announcementLink': instance.announcementLink,
      'alerts': instance.alerts,
      'showStartingDate': instance.showStartingDate?.toIso8601String(),
      'voteStartingDate': instance.voteStartingDate?.toIso8601String(),
      'voteEndingDate': instance.voteEndingDate?.toIso8601String(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PollStatusEnumMap = {
  PollStatus.PREVIEW: 'PREVIEW',
  PollStatus.PUBLISHED: 'PUBLISHED',
  PollStatus.OPEN: 'OPEN',
  PollStatus.CLOSED: 'CLOSED',
};
