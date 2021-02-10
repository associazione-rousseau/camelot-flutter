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

  @JsonKey(fromJson: sortDivisions)
  Paginated<ItalianGeographicalDivision> italianGeographicalDivisions;

  static Paginated<ItalianGeographicalDivision> sortDivisions(Map<String, dynamic> json) {
    final Paginated<
        ItalianGeographicalDivision> italianGeographicalDivisions = Paginated<
        ItalianGeographicalDivision>.fromJson(
        json,
            (Object value) =>
        value == null
            ? null
            : ItalianGeographicalDivision.fromJson(
            value as Map<String, dynamic>));

    italianGeographicalDivisions.nodes.sort((ItalianGeographicalDivision a, ItalianGeographicalDivision b) {
      return b.score - a.score;
    });
    return italianGeographicalDivisions;
  }

  @override
  Paginated<ItalianGeographicalDivision> getPaginatedData() => italianGeographicalDivisions;
}
