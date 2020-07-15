// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approved_candidatures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovedCandidatures _$ApprovedCandidaturesFromJson(Map<String, dynamic> json) {
  return ApprovedCandidatures()
    ..availableForFrontRunning = json['availableForFrontRunning'] as bool
    ..poll = json['poll'] == null
        ? null
        : Poll.fromJson(json['poll'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ApprovedCandidaturesToJson(
        ApprovedCandidatures instance) =>
    <String, dynamic>{
      'availableForFrontRunning': instance.availableForFrontRunning,
      'poll': instance.poll,
    };

Poll _$PollFromJson(Map<String, dynamic> json) {
  return Poll()
    ..title = json['title'] as String
    ..features = json['features'] == null
        ? null
        : Features.fromJson(json['features'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'title': instance.title,
      'features': instance.features,
    };

Features _$FeaturesFromJson(Map<String, dynamic> json) {
  return Features()
    ..frontRunners =
        (json['frontRunners'] as List)?.map((e) => e as String)?.toList()
    ..frontRunnersLabel = json['frontRunnersLabel'] as String;
}

Map<String, dynamic> _$FeaturesToJson(Features instance) => <String, dynamic>{
      'frontRunners': instance.frontRunners,
      'frontRunnersLabel': instance.frontRunnersLabel,
    };
