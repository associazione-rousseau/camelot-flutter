import 'package:json_annotation/json_annotation.dart';

import 'package:rousseau_vote/src/models/interface/has_pagination.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';

import '../italianGeographicalDivision.dart';

part 'italian_geographical_divisions.g.dart';

@JsonSerializable()
class ItalianGeographicalDivisions extends HasPagination<ItalianGeographicalDivision> {
  ItalianGeographicalDivisions();

  factory ItalianGeographicalDivisions.fromJson(Map<String, dynamic> json) =>
      _$ItalianGeographicalDivisionsFromJson(json);
  Map<String, dynamic> toJson() => _$ItalianGeographicalDivisionsToJson(this);

  Paginated<ItalianGeographicalDivision> italianGeographicalDivisions;

  @override
  Paginated<ItalianGeographicalDivision> getPaginatedData() => italianGeographicalDivisions;
}
