import 'package:json_annotation/json_annotation.dart';

part 'place_of_residence.g.dart';

@JsonSerializable()
class PlaceOfResidence {
  PlaceOfResidence();

  factory PlaceOfResidence.fromJson(Map<String, dynamic> json) => _$PlaceOfResidenceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceOfResidenceToJson(this);

  String comuneName;
}
