import 'package:json_annotation/json_annotation.dart';

part 'approved_candidatures.g.dart';

@JsonSerializable()
class ApprovedCandidatures {
  ApprovedCandidatures();

  factory ApprovedCandidatures.fromJson(Map<String, dynamic> json) => _$ApprovedCandidaturesFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovedCandidaturesToJson(this);

  bool availableForFrontRunning;
  Poll poll;
}

@JsonSerializable()
class Poll {
  Poll();

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
  Map<String, dynamic> toJson() => _$PollToJson(this);

  String title;
  Features features;
}

@JsonSerializable()
class Features {
  Features();

  factory Features.fromJson(Map<String, dynamic> json) => _$FeaturesFromJson(json);
  Map<String, dynamic> toJson() => _$FeaturesToJson(this);

  List<String> frontRunners;
  String frontRunnersLabel;
}
