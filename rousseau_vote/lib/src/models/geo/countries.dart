import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/geo/country.dart';

import 'package:rousseau_vote/src/models/interface/has_pagination.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';

part 'countries.g.dart';

@JsonSerializable()
class Countries extends HasPagination<Country> {
  Countries();

  factory Countries.fromJson(Map<String, dynamic> json) => _$CountriesFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesToJson(this);

  Paginated<Country> countriesConnection;

  @override
  Paginated<Country> getPaginatedData() => countriesConnection;
}
